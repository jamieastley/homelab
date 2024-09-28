# Homelab

## Getting Started

- Clone the repository
- Run `make init` to create the `.env` file
  - Update the password in the `.env` file
- Run `make create_volumes` to initialise required volumes
- Start services with `docker compose --env-file /path/to/.env up -d`