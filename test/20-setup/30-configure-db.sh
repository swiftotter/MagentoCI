#!/bin/bash

### 10-local-xml.sh: This file sets up the variables needed for deployment


mysql_execute "UPDATE ${TABLE_PREFIX}core_config_data SET value = '${URL}' WHERE path LIKE 'web/%secure/base_url';"
mysql_execute "UPDATE ${TABLE_PREFIX}core_config_data SET value = '${DOMAIN}' WHERE path = 'web/cookie/cookie_domain';"
mysql_execute "UPDATE ${TABLE_PREFIX}core_config_data SET value = 'bounce@swiftotter.com' WHERE value LIKE '%@%.%';"