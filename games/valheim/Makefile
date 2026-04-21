init:
	echo "#TODO: add required env vars" > .env
	make create_volumes

create_volumes:
	docker volume create --name=valheim_saves
	docker volume create --name=valheim_server_data
	docker volume create --name=valheim_backups
	docker volume create --name=valheim_mod_configs

delete_volumes:
	docker volume rm valheim_saves
	docker volume rm valheim_server_data
	docker volume rm valheim_backups
	docker volume rm valheim_mod_configs

up:
	docker compose up -d

down:
	docker compose down
