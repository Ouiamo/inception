# Variables
DOCKER_COMPOSE = docker compose
COMPOSE_FILE = docker-compose.yml
PROJECT_NAME = inception

# Colors
GREEN = \033[0;32m
RED = \033[0;31m
NC = \033[0m

.PHONY: all build up down clean fclean re logs

all: build redis-up

build:
	@echo "$(GREEN)Building containers...$(NC)"
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

up:
	@echo "$(GREEN)Starting containers...$(NC)"
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

down:
	@echo "$(RED)Stopping containers...$(NC)"
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

logs:
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f

clean: down
	@echo "$(RED)Cleaning containers...$(NC)"
	@docker system prune -f

fclean: clean
	@echo "$(RED)Removing volumes...$(NC)"
	@docker volume rm -f $$(docker volume ls -q --filter name=$(PROJECT_NAME)) 2>/dev/null || true
	@docker system prune -af

re: fclean all

adminer-build:
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build adminer

adminer-up:
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d adminer

adminer-down:
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop adminer

adminer-shell:
	docker exec -it adminer sh

# Add these to your Makefile

redis-build:
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build redis

redis-up:
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d redis

redis-down:
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop redis

redis-shell:
	@docker exec -it redis redis-cli

# Check if containers are running
status:
	@cd srcs && $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps

# Shell into containers
mariadb-shell:
	@docker exec -it mariadb mysql -u root -p

wordpress-shell:
	@docker exec -it wordpress sh

nginx-shell:
	@docker exec -it nginx sh