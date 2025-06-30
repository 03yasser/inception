#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Starting MariaDB service...${NC}"
service mariadb start


echo -e "${YELLOW}Creating database and user...${NC}"
mariadb -e "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;"
mariadb -e "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$USER_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%';"
mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$USER_PASSWORD';"
mariadb -u root -p"$USER_PASSWORD" -e "FLUSH PRIVILEGES;"

sleep 5
echo -e "${GREEN}Stopping MariaDB service...${NC}"
mysqladmin -u root -p"$USER_PASSWORD" shutdown
echo -e "${GREEN}Starting MariaDB server in safe mode...${NC}"
exec mysqld_safe --bind_address=0.0.0.0

