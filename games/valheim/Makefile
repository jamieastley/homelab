init:
	echo "#TODO: add required env vars" > .env
	make create_volumes

create_volumes:
	docker volume create --label game=valheim --name=valhalla-saves
	docker volume create --label game=valheim --name=valhalla-server-data
	docker volume create --label game=valheim --name=valhalla-backups
	docker volume create --label game=valheim --name=valhalla-tailscale
	docker volume create --label game=valheim --name=valhalla-traefik-certs

delete_volumes:
	docker volume rm valhalla-saves
	docker volume rm valhalla-server-data
	docker volume rm valhalla-backups
	docker volume rm valhalla-tailscale
	docker volume rm valhalla-traefik-certs

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
