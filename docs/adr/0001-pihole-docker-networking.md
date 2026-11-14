# Run Pi-hole on the shared Docker network with explicit LAN DNS

Status: accepted. LAN access through both `homelab` and `homelab.local` was
confirmed after deployment on 2026-11-14.

## Decision

Pi-hole uses the shared Docker network rather than host networking so Traefik can discover its
container address and proxy the dashboard without a separate dynamic configuration file. Traefik
shares the Tailscale container's network namespace; when Pi-hole used host networking, Traefik's
fallback backend at `127.0.0.1:80` referred to Traefik itself, not Pi-hole.

DNS is published over TCP and UDP on the host's LAN address and loopback. Pi-hole accepts queries
from all origins because Docker-forwarded requests may not appear to come from a local subnet. These
address bindings are not source filters: Docker-aware firewall rules are needed if untrusted
networks can route to the LAN address. The dashboard is also published on host port 8081 for LAN
access, while Traefik provides HTTPS access over the tailnet.

The Tailscale container advertises a `/32` route to the Pi-hole LAN address; route approval, client
route acceptance, and tailnet DNS settings are separate requirements. The Cloudflare wildcard for
Traefik hostnames must point to the Tailscale container's current Tailscale IP. Pi-hole explicitly
serves the host's LAN address and reverse record because its container no longer shares the host's
network interfaces. It also serves `homelab.<router_hostname>`, matching the LAN's search domain so
clients that qualify the bare hostname can resolve it. `.local` mDNS resolution is separate from
these DNS records.

Pi-hole's automatic IPv4 replies for its own hostname and `pi.hole` are forced to
the host's LAN address. Without this override, naming the container `homelab`
caused Pi-hole to synthesize a Docker interface address for `homelab`, despite
the explicit LAN host record.

The host retains `systemd-resolved` when `/etc/resolv.conf` points to its `127.0.0.53` stub.
Stopping the service with that configuration broke host DNS. Configure the host's network manager to
use Pi-hole as its upstream DNS server if host queries should pass through Pi-hole; starting the
stub alone does not make that change.

## Issues resolved

| Symptom                                                                    | Cause and resolution                                                                                                                                                                        |
|----------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Traefik hostnames failed over Tailscale                                    | The Cloudflare wildcard pointed to an outdated Tailscale IP. Apply the Terraform module with the current Tailscale container IP.                                                            |
| Pi-hole's Traefik backend was `http://127.0.0.1:80` and returned redirects | Pi-hole used host networking while Traefik shared the Tailscale namespace. Put Pi-hole on the shared Docker network so discovery uses its container address.                                |
| Docker rejected custom host-to-IP mapping with the network mode            | `extra_hosts` on Traefik conflicted with `network_mode: service:tailscale`. Remove the mapping; it is unnecessary with shared-network discovery.                                            |
| The host could not resolve public names                                    | `/etc/resolv.conf` referenced `127.0.0.53` while `systemd-resolved` was stopped. Starting the service restored host resolution.                                                             |
| Pi-hole displayed a container ID as its hostname                           | Docker had assigned the default container hostname. Set `hostname: homelab` and recreate the container; this is not automatic detection of the physical host.                               |
| A Mac could resolve with `nslookup` but not with applications              | Cached resolver state contributed to an earlier failure; flushing the Mac's DNS cache restored access then. A successful direct DNS lookup alone does not verify the macOS system resolver. |
| Bare-name access failed again after setting the container hostname         | Pi-hole synthesized `172.27.0.4` for its own hostname despite the LAN host record. Force its automatic IPv4 host replies to the LAN IP.                                                     |
| `homelab.<router_hostname>` returned `NXDOMAIN`                            | The LAN advertises `<router_hostname>` as its search domain, but Pi-hole only had the bare-name record. Add the qualified alias alongside `homelab`.                                        |

The final deployed configuration restored both bare-name and `.local` access.
The earlier published-port UDP timeouts were transient and were not conclusively
explained; do not treat them as evidence that stopping or starting
`systemd-resolved` fixes Docker UDP forwarding.

## First-time setup on a fresh host

Run host commands on the Linux Docker host, not on the Mac.

1. **Reserve a stable LAN address.** Configure a router DHCP reservation or a
   suitable static address for the host. Set `PIHOLE_LAN_IP` in `internal/.env`
   to that address, not a Docker or Tailscale address. Complete the other
   environment variables, secrets, external volumes, and external network
   declared in `internal/compose.yml`. The existing Makefile does not provision
   every Pi-hole resource; check the Compose declarations rather than relying
   on `make init` alone.

2. **Preserve working host DNS during bootstrap.** If `/etc/resolv.conf` uses
   the systemd stub, run `sudo systemctl enable --now systemd-resolved`.
   Keep a working upstream resolver until Pi-hole is running. Pi-hole binds
   `127.0.0.1:53` and the LAN address, leaving `127.0.0.53:53` for the stub.
   Check for conflicting DNS listeners before deployment rather than disabling
   the stub unconditionally.

3. **Configure Pi-hole networking and records.** Keep Pi-hole on the
   `tailscale` Docker network, publish TCP and UDP port 53 on the LAN address
   and `127.0.0.1`, and publish `8081:80/tcp` for direct dashboard access.
   Preserve these settings under the Pi-hole service:

   ```yaml
   hostname: homelab
   environment:
     FTLCONF_dns_upstreams: 1.1.1.1;1.0.0.1
     FTLCONF_dns_listeningMode: ALL
     FTLCONF_dns_hostRecord: "homelab,homelab.<router_hostname>,${PIHOLE_LAN_IP}"
     FTLCONF_dns_reply_host_force4: "true"
     FTLCONF_dns_reply_host_IPv4: "${PIHOLE_LAN_IP}"
   ```

   This is an excerpt, not a replacement for the service's other settings.
   If the host name or DHCP search domain changes, update the names together.
   The force-reply settings cover automatic IPv4 answers such as `homelab`
   and `pi.hole`; the host record supplies the explicit names and reverse record.
   Apply Docker-aware firewall rules to limit published DNS and web ports to
   trusted access paths. Do not expose DNS through WAN port forwarding.

4. **Deploy before switching clients to Pi-hole.** From `internal/`, run
   `docker compose up -d`. After changing an existing container's hostname or
   environment, use `docker compose up -d --force-recreate --no-deps pihole`.
   Recreation preserves the external data volumes. Confirm the direct DNS
   checks below succeed; container health alone only checks its internal
   loopback DNS.

5. **Advertise Pi-hole through DHCP.** On the ASUS router, set the DNS Server
   field under **LAN > DHCP Server > DNS and WINS Server Setting** to the host's
   reserved LAN IP. Leave WINS unchanged. Changing only WAN/upstream DNS is
   not equivalent: clients might continue querying the router rather than
   Pi-hole. Renew client leases or reconnect clients, then inspect their actual
   DNS servers. If the router advertises itself as an additional DNS server,
   disable that advertisement where supported if all queries must use Pi-hole.
   Public secondary resolvers can bypass filtering; Pi-hole as the sole
   resolver makes its availability a dependency for client DNS.

6. **Configure host DNS explicitly if desired.** Use the host's network manager
   to select Pi-hole at `127.0.0.1` or its LAN IP as the upstream, while keeping
   the systemd stub running. Inspect `resolvectl status`; restarting the stub
   does not change DHCP-provided upstream servers. Pi-hole itself uses
   Cloudflare directly, avoiding a host/router forwarding loop.

7. **Configure tailnet access separately.** Approve the advertised
   `${PIHOLE_LAN_IP}/32` route, ensure clients accept subnet routes and access
   policy permits the required traffic, and configure Tailscale DNS to use
   Pi-hole if tailnet clients should query it. Update
   `internal/terraform` with the current Tailscale container IP for `*.ts`.
   These records resolve to a tailnet address and do not provide LAN-only
   access to Traefik. LAN-only clients use published service ports.

8. **Provide mDNS separately if `.local` access is required.** Ensure the Linux
   host advertises `homelab.local` using an mDNS responder such as Avahi, and
   that multicast DNS is permitted on the LAN. Pi-hole's DNS records do not
   configure or replace this mechanism.

## Verification and recovery

On the host, confirm the container hostname and ordinary host resolution:

```sh
docker exec pihole hostname
getent ahostsv4 example.com
resolvectl status
```

The container hostname should be `homelab`. On a LAN client, substitute the
reserved host address below; all three DNS answers should be that LAN address,
never a Docker address:

```sh
dig +short @<host-lan-ip> homelab. A
dig +short @<host-lan-ip> homelab.<router_hostname>. A
dig +short @<host-lan-ip> pi.hole. A
dig +short @<host-lan-ip> -x <host-lan-ip>
```

The reverse lookup should identify `homelab`. On the Mac, inspect the system
resolver and exercise application resolution as well as direct DNS:

```sh
scutil --dns
dscacheutil -q host -a name homelab
curl -I --max-time 5 http://homelab:3552/
curl -I --max-time 5 http://homelab.local:3552/
curl -I --max-time 5 http://homelab:8081/admin/
```

Once direct answers are correct, clear stale macOS DNS entries if applications
still use the previous answer:

```sh
sudo dscacheutil -flushcache
```

If direct DNS is unavailable, compare a query inside the Pi-hole container with
queries to the host's published ports. If the host alone cannot resolve names,
check both the stub service and its upstream configuration. Use the reserved
LAN IP and published web port to reach the dashboard while diagnosing DNS.
For unknown names of other LAN devices, add records or deliberately configure
conditional forwarding to an authoritative router without creating a loop.
