#!/bin/bash

### 90-m1-set-permissions.sh: sets the permissions for Magento 1 projects

if [ -z ${RELEASE_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

## visudo setup:

#Cmnd_Alias      SET_PERMISSIONS = /bin/chown -R apache\:apache /var/www/site/releases/*,/bin/find /var/www/site/releases/*/. -type f -exec chmod 400 {} \\;,/bin/find /var/www/site/releases/*/. -type d -exec chmod 500 {} \\;,/bin/find /var/www/site/releases/*/public/var/ -type f -exec chmod 600 {} \\;,/bin/find /var/www/site/releases/*/public/var/ -type d -exec chmod 700 {} \\;,/bin/chmod 700 /var/www/site/releases/*/public/includes,/bin/chmod 600 /var/www/site/releases/*/public/includes/config.php,/bin/chown -R deploybot\:apache /var/www/site/releases/*/deploy,/bin/chmod 500 /var/www/site/releases/*/deploy,/bin/chmod 550 /var/www/site/releases/*/,/bin/rm -rf /var/www/site/releases/*-*,/bin/chmod +x /var/www/site/*/releases/*/vendor/bin/driver
#
#Cmnd_Alias      SET_LINKS = /bin/ln -snf /var/www/site/releases/* /var/www/site/current
#
#Cmnd_Alias      CLEANUP = /bin/rm -rf /var/www/site/releases/*-*.tar.gz,/bin/rm -rf /var/www/site/releases/*-*
#
#deploybot       ALL=(root)      NOPASSWD:SET_PERMISSIONS
#deploybot       ALL=(root)      NOPASSWD:SET_LINKS
#deploybot       ALL=(apache)    NOPASSWD:CLEANUP

printf "Setting permissions:\n"
if [ -z "${USE_SUDO}" ]; then
    echo "SUDOing: "
    #if [ ! -z "${USER}" ] && [ ! -z "${GROUP}" ]; then
        #sudo chown -R "${USER}:${GROUP}" ${RELEASE_DIR}
    #fi
    sudo find ${RELEASE_DIR}/. -type f -exec chmod 400 {} \;
    sudo find ${RELEASE_DIR}/. -type d -exec chmod 500 {} \;
    sudo chmod 550 ${RELEASE_DIR}/
    sudo find ${RELEASE_DIR}/public/var/ -type f -exec chmod 600 {} \;
    sudo find ${RELEASE_DIR}/public/var/ -type d -exec chmod 700 {} \;
    sudo find ${RELEASE_DIR}/public/media/wysiwyg -type d -exec chmod 755 {} \;
    sudo chmod 700 ${RELEASE_DIR}/public/includes
    sudo chmod 600 ${RELEASE_DIR}/public/includes/config.php
    sudo chmod 500 ${RELEASE_DIR}/deploy
    if [ ! -z "${DEPLOY_USER}" ] && [ ! -z "${GROUP}" ]; then
        sudo chown -R ${DEPLOY_USER}:${GROUP} ${RELEASE_DIR}/deploy
    fi
else
    echo "Not SUDOing: "
    #if [ ! -z "${USER}" ] && [ ! -z "${GROUP}" ]; then
        #chown -R "${USER}:${GROUP}" ${RELEASE_DIR}
    #fi
    find ${RELEASE_DIR}/. -type f -exec chmod 444 {} \;
    find ${RELEASE_DIR}/. -type d -exec chmod 555 {} \;
    chmod 550 ${RELEASE_DIR}/
    find ${RELEASE_DIR}/public/var/ -type f -exec chmod 600 {} \;
    find ${RELEASE_DIR}/public/var/ -type d -exec chmod 700 {} \;
    find ${RELEASE_DIR}/public/media/wysiwyg -type d -exec chmod 755 {} \;
    chmod 700 ${RELEASE_DIR}/public/includes
    chmod 600 ${RELEASE_DIR}/public/includes/config.php
    chmod 500 ${RELEASE_DIR}/deploy
fi
