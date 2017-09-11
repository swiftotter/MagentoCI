#!/bin/bash

### 0-cleanup.sh: This file sets up the variables needed for deployment
logvalue ${BUILD}"/var/cache"
logvalue ${OUTPUT_DIR}
logvalue ${LOCAL_CONFIG}


rm -rf ${BUILD}"/var/cache"
rm -rf ${OUTPUT_DIR}
rm "${LOCAL_CONFIG}"
