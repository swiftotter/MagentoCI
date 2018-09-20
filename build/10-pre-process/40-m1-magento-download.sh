#!/bin/bash

### 40-m1-magento-download.sh: this file installs the composer dependencies

if [ ! -f "${MAGENTO_STAGING}/index.php" ]; then
    printf "Downloading Magento"
    git clone https://github.com/SwiftOtter/magento-mirror.git ${MAGENTO_STAGING}
else
    echo "Magento is already installed, we are not downloading it again."
fi
