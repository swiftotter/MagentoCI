#!/bin/bash

### 20-m2-symlinks.sh: this file sets up the symlinks for necessary files (Magento 2)

logvalue "Applying symbolic links found in the link/ folder."

if [ -z ${LINK_DIR+x} ] || [ -z ${RELEASE_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

## REQUIRED:
mkdir -p ${RELEASE_DIR}/app/etc/
ln -sf ${LINK_DIR}/env.php ${RELEASE_DIR}/app/etc/env.php
rm -rf ${RELEASE_DIR}/pub/media
ln -sf ${LINK_DIR}/media ${RELEASE_DIR}/pub

## OPTIONAL:
[[ -d "${LINK_DIR}/sitemap" ]] && ln -sf ${LINK_DIR}/sitemap ${RELEASE_DIR}/pub
[[ -d "${LINK_DIR}/var/cache" ]] && ln -sf ${LINK_DIR}/var/cache ${RELEASE_DIR}/var
[[ -d "${LINK_DIR}/var/log" ]] && ln -sf ${LINK_DIR}/var/log ${RELEASE_DIR}/var
[[ -d "${LINK_DIR}/var/import" ]] && ln -sf ${LINK_DIR}/var/import ${RELEASE_DIR}/var
[[ -d "${LINK_DIR}/var/report" ]] && ln -sf ${LINK_DIR}/var/report ${RELEASE_DIR}/var
[[ -d "${LINK_DIR}/var/session" ]] && ln -sf ${LINK_DIR}/var/session ${RELEASE_DIR}/var
[[ -f "${LINK_DIR}/var/default.vcl" ]] && ln -sf ${LINK_DIR}/var/default.vcl ${RELEASE_DIR}/var
[[ -f "${LINK_DIR}/var/varnish.vcl" ]] && ln -sf ${LINK_DIR}/var/default.vcl ${RELEASE_DIR}/var
[[ -f "${LINK_DIR}/driver-connections.yaml" ]] && mkdir -p ${RELEASE_DIR}/config.d && ln -sf "${LINK_DIR}/driver-connections.yaml" ${RELEASE_DIR}/config.d/connections.yaml
[[ -d "${LINK_DIR}/blog" ]] && ln -sf ${LINK_DIR}/blog ${RELEASE_DIR}/pub/blog
[[ -f "${LINK_DIR}/home/.htaccess" ]] && ln -sf ${LINK_DIR}/home/.htaccess ${RELEASE_DIR}/pub/.htaccess

## LINK ALL ROBOTS.TXT FILES:
for file in `find ${LINK_DIR} -maxdepth 1 -type f -name "robots*" | xargs -I {} basename {}`
do
    ln -s ${LINK_DIR}/$file ${RELEASE_DIR}/pub/$file
done

## LINK ALL FILES IN link/home DIR:
if [ -d "${LINK_DIR}/home" ]; then
    for f in $(ls -d ${LINK_DIR}/home/*); 
    do 
        ln -s $f ${RELEASE_DIR}/pub/;
    done
fi
