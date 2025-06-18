#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Starting MariaDB service...${NC}"
service mariadb start


echo -e "${YELLOW}Creating database and user...${NC}"
mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};"
mariadb -uroot -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${USER_PASSWORD}';"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%';"
mariadb -uroot  -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
sleep 10
mariadb -uroot -p${MARIADB_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

echo -e "${GREEN}Stopping MariaDB service...${NC}"
mysqladmin -u root -p${MARIADB_ROOT_PASSWORD} shutdown 2>/dev/null || true

echo -e "${GREEN}Starting MariaDB server in safe mode...${NC}"
exec mysqld_safe