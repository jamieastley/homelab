init_env:
	echo "pihole_api_password=changeme" > .env

create_volumes:
	docker volume create --name=homelab_tailscale
	docker volume create --name=homelab_traefik_certs
	docker volume create --name=homelab_hytale_auth_data

delete_volumes:
	docker volume rm portainer_data
	docker volume rm homeassistant_data
	docker volume rm pihole_data
	docker volume rm pihole_logs
	docker volume rm pihole_dnsmasq

up:
	docker compose --env-file .env up -d

down:
	docker compose --env-file .env down
