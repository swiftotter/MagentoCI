#!/bin/bash

### 0-init.sh: This file sets up the variables needed for deployment

BASE=${PWD%/}

export BASE=${BASE}
export RELEASE_PARENT_DIR="${BASE}/releases"
export RELEASE_DIR="${BASE}/releases/${BUILD_ID}"
export LINK_DIR="${BASE}/link"
export OUTPUT_DIR="${BASE}/current"
export OUTPUT_HTML_DIR="${BASE}/html"

ROLLBACK="false"
if [ -d ${RELEASE_DIR} ]; then
    ROLLBACK="true"
fi

export ROLLBACK=$ROLLBACK
