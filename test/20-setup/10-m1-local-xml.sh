#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment

cp "${TEST_SCRIPT_DIR}/files/local.xml" "${LOCAL_XML}"
sed -i -e "s/--crypt-key--/${CRYPT_KEY}/g" "${LOCAL_XML}"
sed -i -e "s/--table-prefix--/${TABLE_PREFIX}/g" "${LOCAL_XML}"
sed -i -e "s/--username--/${MYSQL_USER}/g" "${LOCAL_XML}"
sed -i -e "s/--password--/${MYSQL_PASSWORD}/g" "${LOCAL_XML}"
sed -i -e "s/--database--/${MYSQL_DB_NAME}/g" "${LOCAL_XML}"
