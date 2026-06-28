WAZUH_DIR=wazuh

certs:
	docker compose -f $(WAZUH_DIR)/generate-indexer-certs.yml run --rm generator

up: certs
	docker compose -f $(WAZUH_DIR)/docker-compose.yml up -d

down:
	docker compose -f $(WAZUH_DIR)/docker-compose.yml down

restart: down up

logs:
	docker compose -f $(WAZUH_DIR)/docker-compose.yml logs -f

clean:
	docker compose -f $(WAZUH_DIR)/docker-compose.yml down -v
	rm -rf $(WAZUH_DIR)/config/root-ca
	rm -rf $(WAZUH_DIR)/config/wazuh_*
