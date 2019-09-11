#!/bin/bash

### 110-m2-build-identifier.sh: exports the build number into a Magento 2 project.

if [ ! -z "$BUILD_ID" -a "$BUILD_ID" != " " ]; then
    echo "$BUILD_ID" > "${BUILD_DIR}/app/design/build"
fi

if [ ! -z "$COMMIT" -a "$COMMIT" != " " ]; then
    echo "$COMMIT" > "${BUILD_DIR}/var/sentry-releaseid.txt"
fi
