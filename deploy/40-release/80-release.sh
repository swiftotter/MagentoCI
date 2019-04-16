#!/bin/bash

### 100-release.sh: this flips the symlink over to our new release (aka the moment of truth)

logvalue "Releasing new version."

if [ -z ${RELEASE_DIR+x} ] || [ -z ${OUTPUT_DIR+x} ]; then
    echo "This depends on being executed by all.sh"
    exit
fi

if [[ ! -L "${OUTPUT_DIR}" && -d "${OUTPUT_DIR}" ]]; then
    TIME=$(date +%s)
    mv ${OUTPUT_DIR} ${OUTPUT_DIR}-${TIME}
fi

ln -snf ${RELEASE_DIR} ${OUTPUT_DIR}
