#!/bin/bash

### 110-m1-build-identifier.sh: exports a build number into a Magento 1 project

if [ ! -z "$BUILD_ID" -a "$BUILD_ID" != " " ]; then
    echo "$BUILD_ID" > "${BUILD_DIR}/public/app/design/build"
fi