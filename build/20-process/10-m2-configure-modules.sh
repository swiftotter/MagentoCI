#!/bin/bash

### 10-m2-configure-modules.sh: runs the module installers / uninstaller commands.

logvalue "Executing module installers"

fileiterator "${SCRIPT_BUILD_DIR}/module-installer" ${BUILD_DIR}