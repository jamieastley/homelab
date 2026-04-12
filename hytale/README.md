# Hytale

## Authenticating

### Auth Broker

Run the following command to get a session token after running the service for the first time:

```bash
docker exec -it <broker-container> \
  hytale-session-token-broker -config /app/config.yaml auth-login-device default
```

Auth status can then be checked via:

```bash
docker exec -it <broker-container> \
  hytale-session-token-broker -config /app/config.yaml auth-status default
```

### Game server

The first run of the game server requires manual intervention to authorise the game download.

The auto-download feature uses the official Hytale Downloader CLI. This requires OAuth credentials.
The session token broker can't solve this barrier. The session token broker itself uses OAuth
credentials to generate game session tokens. However, these can only be used to enable player
authentication on the server, not for downloading the server software.
- [Discord message reference](https://discord.com/channels/1459154799407665397/1460066692138008732/1474505393400053962)
- [README.md update](https://github.com/Hybrowse/hytale-server-docker/commit/3eb5a7d2142d56df552eea6c14c3142e4800209e)
