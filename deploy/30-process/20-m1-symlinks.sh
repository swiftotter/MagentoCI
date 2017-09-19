#!/bin/bash

### 20-m1-symlinks.sh: this file sets up the symlinks for necessary files (Magento 2)

if [ -z ${LINK_DIR+x} ] || [ -z ${RELEASE_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

## REQUIRED:
ln -sf ${LINK_DIR}/local.xml ${RELEASE_DIR}/public/app/etc/local.xml
ln -sf ${LINK_DIR}/media ${RELEASE_DIR}/public
ln -sf ${LINK_DIR}/var ${RELEASE_DIR}/public

## OPTIONAL:
[[ -f "${LINK_DIR}/fpc.xml" ]] && ln -sf ${LINK_DIR}/fpc.xml ${RELEASE_DIR}/public/app/etc/fpc.xml
[[ -f "${LINK_DIR}/driver-connections.yaml" ]] && ln -sf "${LINK_DIR}/driver-connections.yaml" ${RELEASE_DIR}/config.d/connections.yaml
[[ -d "${LINK_DIR}/blog" ]] && ln -sf ${LINK_DIR}/blog ${RELEASE_DIR}/public/blog
[[ -d "${LINK_DIR}/sitemap" ]] && ln -sf ${LINK_DIR}/sitemap ${RELEASE_DIR}/public/sitemap
[[ -d "${LINK_DIR}/menu" ]] && ln -sf ${LINK_DIR}/menu ${RELEASE_DIR}/public/menu
if [ -d "${LINK_DIR}/config.d" ]; then
    ln -s ${LINK_DIR}/config.d/* ${RELEASE_DIR}/config.d/
fi

## LINK ALL ROBOTS.TXT FILES:
for file in `find ${LINK_DIR} -maxdepth 1 -type f -name "robots*" | xargs -I {} basename {}`
do
    ln -s ${LINK_DIR}/$file ${RELEASE_DIR}/public/$file
done
