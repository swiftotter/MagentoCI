#!/bin/bash

### 20-m2-merge.sh: runs the compile commands on a Magento 2 project.

cd ${BUILD_DIR}

touch "${BUILD_DIR}/pub/static/deployed_version.txt"

$MAGENTO_CMD config:set dev/css/minify_files 1
$MAGENTO_CMD config:set dev/css/merge_css_files 1
$MAGENTO_CMD config:set dev/js/minify_files 1
$MAGENTO_CMD config:set dev/js/enable_js_bundling 0
$MAGENTO_CMD config:set dev/js/merge_files 0

$MAGENTO_CMD deploy:mode:set production --skip-compilation
$MAGENTO_CMD setup:upgrade
$MAGENTO_CMD setup:di:compile
HTTPS="on"
$MAGENTO_CMD setup:static-content:deploy --content-version=${BUILD_ID} --jobs=1
