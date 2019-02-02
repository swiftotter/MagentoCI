#!/bin/bash

### 30-m2-mysql.sh: this file mysql for the build process

service="mysql"

if (( $(ps -ef | grep ${service} | wc -l) == 0 )); then
   echo "MySQL is not running, or can't be logged into, using \"root\" and no password."
   exit 125
else
    ${MYSQL} -u ${MYSQL_USER} ${MYSQL_PASSWORD_PROMPT} --connect-expired-password <<-EOSQL
        DROP DATABASE IF EXISTS ${DB_NAME};
        CREATE DATABASE ${DB_NAME};
EOSQL
fi
