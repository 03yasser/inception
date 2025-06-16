#!/bin/bash

# Start MariaDB service
echo "Starting MariaDB service..."
service mariadb start

echo "Setting up database with user: ${DB_USER} and database: ${DB_NAME}..."
# This mysql command executes the SQL statements between EOF markers
# mysql -u root <<EOF
# CREATE DATABASE IF NOT EXISTS ${DB_NAME};
# CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
# GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
# FLUSH PRIVILEGES;
# EOF

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER IF NOT EXISTS 'wordpress_user'@'%' IDENTIFIED BY 'secure_password123';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root_password123';
FLUSH PRIVILEGES;
EOF

# Check if the MySQL command was successful
if [ $? -eq 0 ]; then
    echo "MariaDB setup complete!"
else
    echo "Error: MariaDB setup failed"
    exit 1
fi
MYSQL_PWD="root_password123"
sleep 1
# Stop the service before starting mysqld_safe
mysqladmin -u root -p${MYSQL_PWD} shutdown

# Start the MariaDB server in safe mode
echo "Starting MariaDB server in safe mode..."
exec mysqld_safe