#!/bin/bash

### 150-m2-cleanup.sh: removes the database for Magento 2

logvalue "Cleaning up MySQL."

mysql -u root ${MYSQL_PASSWORD_PROMPT} <<-EOSQL
    DROP DATABASE IF EXISTS ${DB_NAME};
EOSQL
