#!/bin/bash

### 30-m2-mysql.sh: this file mysql for the build process

service="mysql"

# ${MYSQL} -u ${MYSQL_USER} ${MYSQL_PASSWORD_PROMPT} --connect-expired-password <<-EOSQL
#     DROP DATABASE IF EXISTS ${DB_NAME};
#     CREATE DATABASE ${DB_NAME};
