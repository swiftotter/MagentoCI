#!/bin/bash

### 10-composer.sh: this file installs the composer dependencies and the base Magento system

logvalue "Setting up Magento 2 Composer Credentials"

if [[ ${TESTMODE} == 0 ]] || [[ -z ${TESTMODE+x} ]]; then
else
  composer config -a -g http-basic.repo.magento.com ${MAGENTO_USERNAME} ${MAGENTO_PASSWORD}
fi
