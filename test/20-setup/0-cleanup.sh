#!/bin/bash

### 0-cleanup.sh: This file sets up the variables needed for deployment

rm -rf ${MAGENTO}"/var/cache"
rm -rf ${OUTPUT_DIR}
rm "${LOCAL_CONFIG}"