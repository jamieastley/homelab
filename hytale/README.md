# Hytale

## Setup

1. Create a `.env` file with the required variables (see below)
2. Run `make init` to create Docker volumes and set data directory permissions
3. Start the stack: `make up`

### Environment variables

| Variable             | Description                                       |
|----------------------|---------------------------------------------------|
| `TS_AUTHKEY`         | Tailscale auth key                                |
| `CF_API_EMAIL`       | Cloudflare account email                          |
| `CF_DOMAIN`          | Domain managed by Cloudflare                      |
| `CF_DNS_API_TOKEN`   | Cloudflare DNS API token (for ACME DNS challenge) |
| `CA_SERVER`          | Let's Encrypt CA URL (staging or production)      |
| `HYTALE_SERVER_NAME` | Display name for the game server                  |
| `HYTALE_OWNER_UUID`  | Owner UUID (used for ownership checks)            |

Optional: set `HYTALE_SESSION_TOKEN_BROKER_BEARER_TOKEN` in `.env` to protect the auth broker API.

## First run

### Auth broker

Authenticate the session token broker after the stack is running:

```bash
docker exec -it hytale_auth \
  hytale-session-token-broker -config /app/config.yaml auth-login-device default
```

Check auth status:

```bash
docker exec -it hytale_auth \
  hytale-session-token-broker -config /app/config.yaml auth-status default
```

### Game server

Allow the `server` service to write to the data/backups directory, see
the [docs here](https://oauth.accounts.hytale.com/oauth2/device/verify?user_code=vGNfKtWC) for more
information:

```bash
sudo chown -R 1000:1001 /path/to/hytale-data
sudo chown -R 1000:1001 /path/to/backups
```

The first run requires manual OAuth intervention to authorise the game download (
`HYTALE_AUTO_DOWNLOAD=true` uses the official Hytale Downloader CLI, which requires separate OAuth
credentials that the session token broker cannot provide).

Attach to the server container and follow the prompts:

```bash
docker attach hytale_server
```

References:

- [Discord message](https://discord.com/channels/1459154799407665397/1460066692138008732/1474505393400053962)
- [Upstream README](https://github.com/Hybrowse/hytale-server-docker/commit/3eb5a7d2142d56df552eea6c14c3142e4800209e)


