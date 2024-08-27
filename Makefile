.PHONY: up, down, build, stop, re

up:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down --rmi all --volumes --remove-orphans

build:
	@docker compose -f ./srcs/docker-compose.yml build

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

re: down up
