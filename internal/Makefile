init:
	echo "#TODO: add required env vars" > .env
	echo "TODO: ts_authkey" > secrets/ts_authkey
	echo "TODO: cf_dns_api_token" > secrets/cf_dns_api_token
	make create_volumes

create_volumes:
	docker volume create --name=arcane_data
	docker volume create --name=arcane_backups

delete_volumes:
	docker volume rm arcane_data

up:
	docker compose up -d

down:
	docker compose down
