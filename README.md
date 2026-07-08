# SOC Lab — Wazuh SIEM + Victim Machines

Build a Security Operations Center (SOC) with Wazuh, launch attacks against your own infrastructure, and practice detection and response.

## Architecture

| Service | Role |
|---|---|
| `wazuh.manager` | Wazuh manager — SIEM server, agent management, alerting |
| `wazuh.indexer` | Wazuh indexer — OpenSearch storage and indexing |
| `wazuh.dashboard` | Wazuh dashboard — OpenSearch Dashboards + Wazuh plugin UI |
| `victim1` | Debian machine with Wazuh agent, SSH, syslog |
| `victim2` | Debian machine with Wazuh agent, SSH, syslog |

## Prerequisites

- Linux with Docker and Docker Compose plugin
- Ports 443, 514/udp, 1514, 1515, 9200, 55000 available (or adjust port mappings)

## Quick start

```bash
sudo sysctl -w vm.max_map_count=262144
make up
```

The first startup takes about 1 minute while the indexer initializes.

## Access the dashboard

Open **https://localhost** in your browser.

| User | Password |
|---|---|
| `admin` | `SecretPassword` |
| `kibanaserver` | `kibanaserver` |

## How to use this lab

1. **Attack** — SSH into a victim container and simulate malicious activity (e.g., failed logins, privilege escalation, file changes).
2. **Detect** — Watch alerts appear in the Wazuh dashboard under the **Modules** or **Security events** sections.
3. **Investigate** — Use the dashboard to explore the full event data, create custom rules, and run queries against the indexer.
4. **Expand** — Add more victims, services, or custom detection rules to the lab.

## Useful commands

| Action | Command |
|---|---|
| Start everything | `make up` |
| Stop everything | `make down` |
| Follow Wazuh logs | `make logs` |
| Follow victim logs | `make victim-logs` |
| Regenerate certificates | `make certs` |

## Credentials

| Purpose | Username | Password |
|---|---|---|
| Wazuh Indexer / Dashboard admin | `admin` | `SecretPassword` |
| Dashboard Kibana server | `kibanaserver` | `kibanaserver` |
| Wazuh API (WUI) | `wazuh-wui` | `MyS3cr37P450r.*-` |

## Network

All containers communicate over a shared Docker bridge network called **`soc-net`** (created automatically by the Wazuh stack).

## Troubleshooting

- **Certificate permission denied**: After `make certs`, the `wazuh/config/wazuh_indexer_ssl_certs/` directory is owned by root. Run `sudo chown -R $USER:$USER wazuh/config/wazuh_indexer_ssl_certs` if needed.
- **Victims fail to connect**: Start the Wazuh stack first so the `soc-net` network is created before the victims.
- **Dashboard shows "Connection failed"**: Wait ~1 minute for the indexer to finish initializing, then refresh.
- **Port conflicts**: Edit port mappings in `wazuh/docker-compose.yml`.
