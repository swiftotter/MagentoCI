#!/bin/bash

### 100-release.sh: this flips the symlink over to our new release (aka the moment of truth)

logvalue "Releasing new version."

if [ -z ${RELEASE_DIR+x} ] || [ -z ${OUTPUT_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

ln -snf ${RELEASE_DIR} ${OUTPUT_DIR}


## Cleaning PHP7 opcaches
echo ${RELEASE_DIR}/vendor/bin/cachetool
if [[ -d "${RELEASE_DIR}/vendor/bin/cachetool" ]]; then
    (cd ${RELEASE_DIR} && ${PHP} vendor/gordalina/cachetool/bin/cachetool opcache:reset)
fi