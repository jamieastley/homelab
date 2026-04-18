init:
	echo "#TODO: add required env vars" > .env
	make create_volumes
	# https://github.com/Hybrowse/hytale-server-docker/blob/main/docs/image/troubleshooting.md#permission-denied-errors-on-data
	sudo chown -R 1001:1001 ./hytale-data

create_volumes:
	docker volume create --name=hytale_tailscale
	docker volume create --name=hytale_traefik_certs
	docker volume create --name=hytale_auth_data

delete_volumes:
	docker volume rm hytale_tailscale
	docker volume rm hytale_traefik_certs
	docker volume rm hytale_auth_data

up:
	docker compose up -d

down:
	docker compose down
