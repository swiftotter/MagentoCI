#!/bin/bash

### 100-m1-merge.sh: merges Magento 1 folders together.

mkdir -p ${BUILD_DIR}/public/
mkdir -p ${BUILD_DIR}/scripts/
mkdir -p ${BUILD_DIR}/config.d/
rsync_cmd="rsync --recursive --copy-links --specials --exclude='.git/' --exclude='*README*'"

## Starting with magento's staging
${rsync_cmd} --exclude='dev/' --exclude='downloader/' --exclude='tests/' --exclude='var/' --exclude='*.sample' --exclude='LICENSE.*' ${MAGENTO_STAGING}/. ${BUILD_DIR}/public/
rm -rf ${BUILD_DIR}/public/media/

## Merging the code folders (customizations is after so it can override files from /extensions
if [[ -d "${EXTENSIONS_DIR}" ]]; then
    echo "${rsync_cmd} --exclude='*modman*' ${EXTENSIONS_DIR}/. ${BUILD_DIR}/public/"
    ${rsync_cmd} --exclude='*modman*' ${EXTENSIONS_DIR}/. ${BUILD_DIR}/public/
fi

echo "${rsync_cmd} ${SCRIPT_DIR}/. ${BUILD_DIR}/scripts/"

## Bringing in the deploy scripts
${rsync_cmd} ${SCRIPT_DIR}/. ${BUILD_DIR}/scripts/

## Bringing in the ancillary configuration
if [[ -d "${CONFIG_DIR}" ]]; then
    echo "${rsync_cmd} ${CONFIG_DIR} ${BUILD_DIR}/"
    ${rsync_cmd} ${CONFIG_DIR} ${BUILD_DIR}/
fi

## Adding the home folder overrides
if [[ -d "${HOME_DIR}" ]]; then
    echo "${rsync_cmd} ${HOME_DIR}/. ${BUILD_DIR}/public/"
    ${rsync_cmd} ${HOME_DIR}/. ${BUILD_DIR}/public/
fi

## Copying "public" composer files (those that go in the public/ folder)
if [[ -d "${CORE_DIR}" ]]; then
    echo "${rsync_cmd} ${CORE_DIR}/. ${BUILD_DIR}/public/"
    ${rsync_cmd} ${CORE_DIR}/. ${BUILD_DIR}/public/
fi

## Copying "private" composer files (those that stay in vendor/)
if [[ -f "${BASE}/phpunit.xml" ]]; then
    ${rsync_cmd} ${BASE}/phpunit.* ${BUILD_DIR}
fi

## Copying "private" composer files (those that stay in vendor/)
if [[ -f "${BASE}/composer.json" ]]; then
    echo "${rsync_cmd} ${BASE}/composer.* ${BUILD_DIR}"
    ${rsync_cmd} ${BASE}/composer.* ${BUILD_DIR}
    echo "${rsync_cmd} ${BASE}/vendor/. ${BUILD_DIR}/vendor"
    ${rsync_cmd} ${BASE}/vendor/. ${BUILD_DIR}/vendor
fi

## Merging the code folders (customizations is after so it can override files from /extensions)
if [[ -d "${CUSTOMIZATIONS_DIR}" ]]; then
    echo "${rsync_cmd} --exclude='*modman*' --exclude='vendor/' ${CUSTOMIZATIONS_DIR}/. ${BUILD_DIR}/public/"
    ${rsync_cmd} --exclude='*modman*' --exclude='vendor/' ${CUSTOMIZATIONS_DIR}/. ${BUILD_DIR}/public/
fi

if [[ -d "${CUSTOMIZATIONS_DIR}/vendor/" ]]; then
    echo "${rsync_cmd} --exclude='*modman*' ${CUSTOMIZATIONS_DIR}/vendor/. ${BUILD_DIR}/vendor/"
    ${rsync_cmd} --exclude='*modman*' ${CUSTOMIZATIONS_DIR}/vendor/. ${BUILD_DIR}/vendor/
fi
