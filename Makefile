init:
	echo "#TODO: add required env vars" > .env
	make create_volumes

create_volumes:
	docker volume create --name=arcane_data

delete_volumes:
	docker volume rm arcane_data

up:
	docker compose up -d

down:
	docker compose down
