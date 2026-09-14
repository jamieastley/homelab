# Homelab - Internal

If running this Compose stack for the first time, run the following command to initialise the required `.env` file:

```shell
make init
```

## Environment Variables

Create a `.env` file in this directory. The following variables are required:

| Variable                 | Description                                   | Example                 |
|--------------------------|-----------------------------------------------|-------------------------|
| `CF_API_EMAIL`           | Cloudflare account email (ACME DNS challenge) | `someone@example.com`   |
| `CF_DOMAIN`              | Base domain for Traefik routes                | `example.com`           |
| `PROJECT_PREFIX`         | Prefix for container names                    | `homelab`               |
| `TAILSCALE_NETWORK`      | External Docker network name                  | `homelab_tailscale`     |
| `TAILSCALE_STATE_VOLUME` | External volume for Tailscale state           | `homelab_tailscale`     |
| `TRAEFIK_CERTS_VOLUME`   | External volume for ACME certificates         | `homelab_traefik_certs` |
| `TRAEFIK_INSTANCE`       | Docker provider constraint label value        | `homelab`               |
| `TS_HOSTNAME`            | Tailscale hostname for this host              | `homelab`               |

### Optional

These have defaults defined in the compose files:

| Variable            | Description                                        | Default                                          |                                         
|---------------------|----------------------------------------------------|--------------------------------------------------|
| `ACME_CA_SERVER`    | ACME directory URL (use staging URL while testing) | `https://acme-v02.api.letsencrypt.org/directory` | 
| `ACME_STORAGE`      | Path for ACME account/certificate storage          | `/certs/acme.json`                               |  
| `ARCANE_SUBDOMAIN`  | Subdomain for the Arcane manager                   | `arcane.ts`                                      |   
| `TRAEFIK_SUBDOMAIN` | Subdomain for the Traefik dashboard                | `traefik.ts`                                     | 

## Volumes

The stack requires the following **external** Docker volumes to be created beforehand (e.g.
`docker volume create <name>`):

| Volume                  | Used by   | Purpose                                                                   |
|-------------------------|-----------|---------------------------------------------------------------------------|
| `homelab_tailscale`     | tailscale | Persistent Tailscale state (also referenced via `TAILSCALE_STATE_VOLUME`) |
| `homelab_traefik_certs` | traefik   | ACME certificate storage (also referenced via `TRAEFIK_CERTS_VOLUME`)     |
| `arcane_data`           | arcane    | Arcane application data                                                   |
| `arcane_backups`        | arcane    | Arcane backups                                                            |

These can be created via either provided `Makefile`

```shell
make create_volumes
```

The external Docker network `homelab_tailscale` must also exist:

```sh
docker network create homelab_tailscale
```

## Secrets

The following files must exist under `./secrets/`:

- `secrets/ts_authkey` — Tailscale auth key
- `secrets/cf_dns_api_token` — Cloudflare DNS API token
- `secrets/arcane_encryption_key` — Arcane encryption key
