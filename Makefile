WAZUH_DIR := wazuh
VICTIMS_DIR := victims

.PHONY: certs up down logs clean

certs:
	docker compose -f $(WAZUH_DIR)/generate-indexer-certs.yml run --rm generator

up: certs
	docker compose -f $(WAZUH_DIR)/docker-compose.yml up -d
	docker compose -f $(VICTIMS_DIR)/docker-compose.yml up -d --build

down:
	docker compose -f $(VICTIMS_DIR)/docker-compose.yml down -v
	docker compose -f $(WAZUH_DIR)/docker-compose.yml down -v

logs:
	docker compose -f $(WAZUH_DIR)/docker-compose.yml logs -f

victim-logs:
	docker compose -f $(VICTIMS_DIR)/docker-compose.yml logs -f
