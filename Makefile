DC_file = srcs/docker-compose.yml
DC = docker compose

all: up

build:
	$(DC) -f $(DC_file) build

up: build
	$(DC) -f $(DC_file) up

down:
	$(DC) -f $(DC_file) down

mariadb:
	docker container exec -it mariadb bash

clean:
	$(DC) -f $(DC_file) down --remove-orphans
	$(DC) -f $(DC_file) rm -f

fclean: clean
	docker compose -f $(DC_file) down --rmi all
	docker container prune -f

re: fclean all

.PHONY: all up down build clean fclean re mariadb