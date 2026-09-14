# Homelab - Internal

## Environment Variables

Create a `.env` file in this directory. The following variables are required:

| Variable                 | Description                                   | Example                 |
|--------------------------|-----------------------------------------------|-------------------------|
| `CF_API_EMAIL`           | Cloudflare account email (ACME DNS challenge) | `someone@example.com`   |
| `CF_DOMAIN`              | Base domain for Traefik routes                | `example.com`           |
| `TS_HOSTNAME`            | Tailscale hostname for this host              | `homelab`               |
| `PROJECT_PREFIX`         | Prefix for container names                    | `homelab`               |
| `TAILSCALE_STATE_VOLUME` | External volume for Tailscale state           | `homelab_tailscale`     |
| `TAILSCALE_NETWORK`      | External Docker network name                  | `homelab_tailscale`     |
| `TRAEFIK_CERTS_VOLUME`   | External volume for ACME certificates         | `homelab_traefik_certs` |
| `TRAEFIK_INSTANCE`       | Docker provider constraint label value        | `homelab`               |
| `TRAEFIK_SUBDOMAIN`      | Subdomain for the Traefik dashboard           | `traefik.ts`            |
| `ARCANE_SUBDOMAIN`       | Subdomain for the Arcane manager              | `arcane.ts`             |

### Optional

These have defaults defined in the compose files:

| Variable         | Default                                          | Description                                        |
|------------------|--------------------------------------------------|----------------------------------------------------|
| `ACME_CA_SERVER` | `https://acme-v02.api.letsencrypt.org/directory` | ACME directory URL (use staging URL while testing) |
| `ACME_STORAGE`   | `/certs/acme.json`                               | Path for ACME account/certificate storage          |

## Secrets

The following files must exist under `./secrets/`:

- `secrets/ts_authkey` — Tailscale auth key
- `secrets/cf_dns_api_token` — Cloudflare DNS API token
- `secrets/arcane_encryption_key` — Arcane encryption key
