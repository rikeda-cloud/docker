.PHONY: up, down, build, stop, re

DOCKER_COMPOSE = docker compose
COMPOSE_YML_PATH = ./srcs/docker-compose.yml

up:
	${DOCKER_COMPOSE} -f ${COMPOSE_YML_PATH} up -d --build

down:
	${DOCKER_COMPOSE} -f ${COMPOSE_YML_PATH} down --rmi all --volumes --remove-orphans

build:
	${DOCKER_COMPOSE} -f ${COMPOSE_YML_PATH} build

stop:
	${DOCKER_COMPOSE} -f ${COMPOSE_YML_PATH} stop

re: down up
