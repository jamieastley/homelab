init:
	echo "#TODO: add required env vars" > .env-test
	make create_volumes
	make create_networks

create_volumes:
	docker volume create --name=games_traefik_certs

create_networks:
	docker network create games_tailscale

delete_volumes:
	docker volume rm games_traefik_certs

delete_networks:
	docker network rm games_tailscale

up:
	docker compose up -d

down:
	docker compose down
