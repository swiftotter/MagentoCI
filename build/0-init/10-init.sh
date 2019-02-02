#!/bin/bash

### 10-init.sh: this file initializes all variables needed for the build process

logvalue "Initializing variables"

base=$(pwd)
base=${base%/}
export BASE=$base

## Code directories
export CHECKOUT_DIR="${base}/checkout"

export SCRIPT_DIR="${base}/scripts"
export SCRIPT_DEPLOY_DIR="${base}/scripts/deploy"
export SCRIPT_BUILD_DIR="${base}/scripts/build"

export MAGENTO_STAGING="${base}/magento"
export CONFIG_DIR="${base}/checkout/config.d"
export BUILD_DIR="${base}/build"
export BUILD_FILE="${base}/build.tar.gz"

export COMPOSER_CMD="$PHP /usr/local/bin/composer"
export PHP_CMD="$PHP -dmemory_limit=1500M"
export MYSQL="mysql -h$MYSQL_HOST"


mkdir -p "${BUILD_DIR}"
