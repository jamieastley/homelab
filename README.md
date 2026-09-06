# Homelab

## Getting Started

- Clone the repository
- Run `make init` to create the `.env` file
    - Update the values in the `.env` file
- Run `make create_volumes` to initialise required volumes
- Start services with `docker compose --env-file /path/to/.env up -d`
    - Or use `make up-staging` / `make up-prod` to switch between Let's Encrypt staging and
      production without editing `.env`

### Environment Variables

| Variable           | Description                                       | Default                                          |
|--------------------|---------------------------------------------------|--------------------------------------------------|
| `CF_API_EMAIL`     | Cloudflare account email                          | -                                                |
| `CF_DOMAIN`        | Domain managed by Cloudflare                      | -                                                |
| `CF_DNS_API_TOKEN` | Cloudflare DNS API token (for ACME DNS challenge) | -                                                |
| `ACME_CA_SERVER`   | Let's Encrypt CA directory URL                    | `https://acme-v02.api.letsencrypt.org/directory` |
| `ACME_STORAGE`     | Path to the ACME certificate storage file         | `/certs/acme.json`                               |

Use the staging CA (`https://acme-staging-v02.api.letsencrypt.org/directory`) and a separate storage
file (e.g., `/certs/acme-staging.json`) to avoid production rate limits while testing.
