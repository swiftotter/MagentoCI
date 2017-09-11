#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

echo "Downloading Driver dump\n"
aws s3 cp s3://${S3_BUCKET}/${DB_FILE} ${MYSQL_DB_NAME}.gz

echo "Unzipping dump...\n"
gunzip --force ${MYSQL_DB_NAME}.gz

echo "Importing into MySQL...\n"
mysql -u ${MYSQL_USER} --password=${MYSQL_PASSWORD} --execute="CREATE DATABASE ${MYSQL_DB_NAME}"
#mysql -u ${MYSQL_USER} --password=${MYSQL_PASSWORD} ${MYSQL_DB_NAME} < ${MYSQL_DB_NAME}

echo "Removing dump\n"
rm ${MYSQL_DB_NAME}
