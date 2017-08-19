#!/bin/bash

### 10-symlinks.sh: currently empty, but this would setup symlinks for both Magento 1 and Magento 2

if [ -z ${LINK_DIR+x} ] || [ -z ${RELEASE_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi