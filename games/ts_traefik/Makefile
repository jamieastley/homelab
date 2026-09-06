init:
	echo "#TODO: add required env vars" > .env
	echo "CF_API_EMAIL=\"\"" >> .env
	echo "CF_DOMAIN=\"\"" >> .env
	echo "CF_DNS_API_TOKEN=\"\"" >> .env
	echo "ACME_CA_SERVER=\"https://acme-v02.api.letsencrypt.org/directory\"" >> .env
	echo "ACME_STORAGE=\"/certs/acme.json\"" >> .env
	make create_volumes

create_networks:
	docker network create games_server_tailscale

create_volumes:
	docker volume create --name=games_server_tailscale
	docker volume create --name=games_server_traefik_certs

delete_volumes:
	docker volume rm games_server_tailscale
	docker volume rm games_server_traefik_certs

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
