WAZUH_DIR := wazuh
VICTIMS_DIR := victims

.PHONY: up certs down logs victim-logs

up: certs
	docker compose -f $(WAZUH_DIR)/docker-compose.yml up -d --build
	docker compose -f $(VICTIMS_DIR)/docker-compose.yml up -d --build

certs:
	docker compose -f $(WAZUH_DIR)/generate-indexer-certs.yml run --rm generator

down:
	docker compose -f $(VICTIMS_DIR)/docker-compose.yml down -v
	docker compose -f $(WAZUH_DIR)/docker-compose.yml down -v

logs:
	docker compose -f $(WAZUH_DIR)/docker-compose.yml logs -f

victim-logs:
	docker compose -f $(VICTIMS_DIR)/docker-compose.yml logs -f
