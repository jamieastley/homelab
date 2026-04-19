init:
	echo "#TODO: add required env vars" > .env
	make create_volumes

create_volumes:
	docker volume create --name=valheim_tailscale
	docker volume create --name=valheim_traefik_certs

delete_volumes:
	docker volume rm valheim_tailscale
	docker volume rm valheim_traefik_certs

up:
	docker compose up -d

down:
	docker compose down
