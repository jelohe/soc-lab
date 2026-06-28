FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
      netcat-traditional \
      curl \
      sudo \
      vim \
      wget \
      gnupg \
      lsb-release \
      apt-transport-https \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | \
      gpg --dearmor -o /usr/share/keyrings/wazuh.gpg

RUN echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt stable main" \
      > /etc/apt/sources.list.d/wazuh.list

RUN apt-get update && \
    apt-get install -y wazuh-agent && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY ossec.conf.template /ossec.conf.template

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
