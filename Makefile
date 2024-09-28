init_env:
	echo "pihole_api_password=changeme" > .env

create_volumes:
	docker volume create --name=portainer_data
	docker volume create --name=homeassistant_data
	docker volume create --name=pihole_data
	docker volume create --name=pihole_logs
	docker volume create --name=pihole_dnsmasq

delete_volumes:
	docker volume rm portainer_data
	docker volume rm homeassistant_data
	docker volume rm pihole_data
	docker volume rm pihole_logs
	docker volume rm pihole_dnsmasq