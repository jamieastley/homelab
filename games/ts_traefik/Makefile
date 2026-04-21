init:
	echo "#TODO: add required env vars" > .env
	make create_volumes

create_networks:
	docker network create games_server_tailscale

create_volumes:
	docker volume create --name=games_server_tailscale
	docker volume create --name=games_server_traefik_certs

delete_volumes:
	docker volume rm games_server_tailscale
	docker volume rm games_server_traefik_certs

up:
	docker compose up -d

down:
	docker compose down
