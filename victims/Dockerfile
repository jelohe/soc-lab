FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive

# Packages
RUN apt-get update && apt-get install -y \
    bash \
    sudo \
    openssh-server \
    curl \
    procps \
    iproute2 \
    iptables \
    netcat-openbsd \
    logrotate \
    rsyslog \
    ca-certificates \
    vim \
    gnupg \
    lsb-release \
 && rm -rf /var/lib/apt/lists/*

# SSH Keys
RUN mkdir -p /run/sshd && \
    ssh-keygen -A

# Wazuh-agent
RUN mkdir -p /usr/share/keyrings && \
    curl -fsSL https://packages.wazuh.com/key/GPG-KEY-WAZUH \
    | gpg --dearmor -o /usr/share/keyrings/wazuh.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt stable main" \
    > /etc/apt/sources.list.d/wazuh.list

RUN apt-get update && \
    apt-get install -y wazuh-agent && \
    rm -rf /var/lib/apt/lists/*

# Config files
COPY entrypoint.sh /entrypoint.sh
COPY ossec.conf.template /ossec.conf.template

RUN chmod +x /entrypoint.sh

EXPOSE 22

CMD ["/entrypoint.sh"]
