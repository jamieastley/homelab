init:
	echo "#TODO: add required env vars" > .env
	echo "TODO: ts_authkey" > secrets/ts_authkey
	echo "TODO: cf_dns_api_token" > secrets/cf_dns_api_token
	echo "TODO: arcane_encryption_key" > secrets/arcane_encryption_key
	echo "TODO: arcane_jwt_secret" > secrets/arcane_jwt_secret
	echo "TODO: pihole_webpassword" > secrets/pihole_webpassword
	make create_volumes

create_volumes:
	docker volume create --name=homelab_tailscale
	docker volume create --name=homelab_traefik_certs
	docker volume create --name=arcane_data
	docker volume create --name=arcane_backups
	docker volume create --name=pihole_logs
	docker volume create --name=pihole_data
	docker volume create --name=pihole_dnsmasq_data

delete_volumes:
	docker volume rm homelab_tailscale
	docker volume rm homelab_traefik_certs
	docker volume rm arcane_data
	docker volume rm arcane_backups
	docker volume rm pihole_logs
	docker volume rm pihole_data
	docker volume rm pihole_dnsmasq_data

up:
	docker compose up -d

down:
	docker compose down
