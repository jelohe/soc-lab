#!/bin/bash
set -e

WAZUH_MANAGER=${WAZUH_MANAGER:-wazuh.manager}
AUTH_PASS=${AUTH_PASS:-SecretPassword}

echo "[1/3] Waiting for manager..."

until nc -z $WAZUH_MANAGER 1515; do
  sleep 3
done

echo "[2/3] Enrolling agent..."

cp /ossec.conf.template /var/ossec/etc/ossec.conf
sed -i "s|__WAZUH_MANAGER__|${WAZUH_MANAGER}|g" \
    /var/ossec/etc/ossec.conf

rm -rf /var/ossec/queue/rids/* || true
rm -f /var/ossec/etc/client.keys || true

/var/ossec/bin/agent-auth \
  -m $WAZUH_MANAGER \
  -A $(hostname)

echo "[3/3] Starting agent..."

/var/ossec/bin/wazuh-control start

tail -f /dev/null
