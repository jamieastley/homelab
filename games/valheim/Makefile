init:
	echo "#TODO: add required env vars" > .env
	make create_volumes

create_volumes:
	docker volume create --label game=valheim --name=valhalla_saves
	docker volume create --label game=valheim --name=valhalla_server_data
	docker volume create --label game=valheim --name=valhalla_backups
	docker volume create --label game=valheim --name=valhalla_mod_configs
	docker volume create --label game=valheim --name=valhalla_tailscale
	docker volume create --label game=valheim --name=valhalla_traefik_certs

delete_volumes:
	docker volume rm valhalla_saves
	docker volume rm valhalla_server_data
	docker volume rm valhalla_backups
	docker volume rm valhalla_mod_configs
	docker volume rm valhalla_tailscale
	docker volume rm valhalla_traefik_certs

up-staging:
	ACME_CA_SERVER="https://acme-staging-v02.api.letsencrypt.org/directory" \
	ACME_STORAGE="/certs/acme-staging.json" \
	docker compose up -d

up-prod:
	ACME_CA_SERVER="https://acme-v02.api.letsencrypt.org/directory" \
	ACME_STORAGE="/certs/acme.json" \
	docker compose up -d

down:
	docker compose down
