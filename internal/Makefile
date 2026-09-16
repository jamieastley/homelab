init:
	echo "#TODO: add required env vars" > .env
	# Required
	echo "CF_API_EMAIL=\"\"" >> .env
	echo "CF_DOMAIN=\"\"" >> .env
	echo "PROJECT_PREFIX=\"homelab\"" >> .env
	echo "TAILSCALE_INSTANCE=\"homelab\"" >> .env
	echo "TS_HOSTNAME=\"homelab\"" >> .env
	# Optional
	echo "ACME_CA_SERVER=\"https://acme-v02.api.letsencrypt.org/directory\"" >> .env
	echo "ACME_STORAGE=\"/certs/acme.json\"" >> .env
	echo "ARCANE_SUBDOMAIN=\"arcane.ts\"" >> .env
	echo "TRAEFIK_SUBDOMAIN=\"traefik.ts\"" >> .env
	# Secrets
	echo "TODO: ts_authkey" > secrets/ts_authkey
	echo "TODO: cf_dns_api_token" > secrets/cf_dns_api_token
	echo "TODO: arcane_encryption_key" > secrets/arcane_encryption_key
	make create_volumes

create_volumes:
	docker volume create --name=homelab_tailscale
	docker volume create --name=homelab_traefik_certs
	docker volume create --name=arcane_data
	docker volume create --name=arcane_backups

delete_volumes:
	docker volume rm homelab_tailscale
	docker volume rm homelab_traefik_certs
	docker volume rm arcane_data
	docker volume rm arcane_backups

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
