FROM debian:latest

RUN echo "Installing MariaDB dependencies..." && \
    apt update && \
    apt install -y mariadb-server mariadb-client

COPY ./tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

CMD ["/tmp/script.sh"]
