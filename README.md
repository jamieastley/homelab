# Homelab

## Getting Started

- Create an `.env` file in the root of the project with the following content:
  ```env
  pihole_api_password=hunter12
  ```
- Start services with `docker compose --env-file /path/to/.env up -d`