.PHONY: up, down, re

up:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down --rmi all --volumes --remove-orphans

re: down up
