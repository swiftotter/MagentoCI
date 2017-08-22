#!/bin/bash

### 100-m1-merge.sh: merges Magento 1 folders together.

mkdir -p ${BUILD_DIR}/public/
mkdir -p ${BUILD_DIR}/scripts/
mkdir -p ${BUILD_DIR}/config.d/
rsync_cmd="rsync --recursive --copy-links --specials --exclude='.git/' --exclude='*README*'"

ls ${CHECKOUT_DIR}

## Starting with magento's staging
${rsync_cmd} --exclude='dev/' --exclude='downloader/' --exclude='tests/' --exclude='var/' --exclude='*.sample' --exclude='LICENSE.*' ${MAGENTO_STAGING}/. ${BUILD_DIR}/public/
rm -rf ${BUILD_DIR}/public/media/

## Merging the code folders (customizations is after so it can override files from /extensions
if [[ -d "${CHECKOUT_DIR}/extensions" ]]; then
    echo "${rsync_cmd} --exclude='*modman*' ${CHECKOUT_DIR}/extensions/. ${BUILD_DIR}/public/\n"
    ${rsync_cmd} --exclude='*modman*' ${CHECKOUT_DIR}/extensions/. ${BUILD_DIR}/public/
fi


echo "${rsync_cmd} ${SCRIPT_DIR}/. ${BUILD_DIR}/scripts/"

## Bringing in the deploy scripts
${rsync_cmd} ${SCRIPT_DIR}/. ${BUILD_DIR}/scripts/

## Bringing in the ancillary configuration
if [[ -d "${CONFIG_DIR}" ]]; then
    echo "${rsync_cmd} ${CONFIG_DIR} ${BUILD_DIR}/\n"
    ${rsync_cmd} ${CONFIG_DIR} ${BUILD_DIR}/
fi


## Adding the home folder overrides
if [[ -d "${HOME_DIR}" ]]; then
    echo "${rsync_cmd} ${HOME_DIR}/. ${BUILD_DIR}/public/\n"
    ${rsync_cmd} ${HOME_DIR}/. ${BUILD_DIR}/public/
fi


## Copying "public" composer files (those that go in the public/ folder)
if [[ -d "${CHECKOUT_DIR}/core" ]]; then
    echo "${rsync_cmd} ${CHECKOUT_DIR}/core/. ${BUILD_DIR}/public/\n"
    ${rsync_cmd} ${CHECKOUT_DIR}/core/. ${BUILD_DIR}/public/
fi


## Copying "private" composer files (those that stay in vendor/)
if [[ -f "${CHECKOUT_DIR}/phpunit.xml" ]]; then
    ${rsync_cmd} ${CHECKOUT_DIR}/phpunit.* ${BUILD_DIR}
fi


## Copying "private" composer files (those that stay in vendor/)
if [[ -f "${CHECKOUT_DIR}/composer.json" ]]; then
    echo "${rsync_cmd} ${CHECKOUT_DIR}/composer.* ${BUILD_DIR}\n"
    ${rsync_cmd} ${CHECKOUT_DIR}/composer.* ${BUILD_DIR}
fi


## Copying "private" composer files (those that stay in vendor/)
if [[ -d "${CHECKOUT_DIR}/vendor" ]]; then
    echo "${rsync_cmd} ${CHECKOUT_DIR}/vendor/. ${BUILD_DIR}/vendor\n"
    ${rsync_cmd} ${CHECKOUT_DIR}/vendor/. ${BUILD_DIR}/vendor
fi


## Merging the code folders (customizations is after so it can override files from /extensions)
if [[ -d "${CHECKOUT_DIR}/customizations" ]]; then
    echo "${rsync_cmd} --exclude='*modman*' --exclude='vendor/' ${CHECKOUT_DIR}/customizations/. ${BUILD_DIR}/public/\n"
    ${rsync_cmd} --exclude='*modman*' --exclude='vendor/' ${CHECKOUT_DIR}/customizations/. ${BUILD_DIR}/public/
fi

if [[ -d "${CHECKOUT_DIR}/customizations/vendor/" ]]; then
    echo "${rsync_cmd} --exclude='*modman*' ${CHECKOUT_DIR}/customizations/vendor/. ${BUILD_DIR}/vendor/\n"
    ${rsync_cmd} --exclude='*modman*' ${CHECKOUT_DIR}/customizations/vendor/. ${BUILD_DIR}/vendor/
fi
