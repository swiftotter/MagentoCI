#!/bin/bash

### 90-m2-set-permissions.sh: sets the permissions for Magento 2 projects

logvalue "Setting directory permissions:"
#find ${RELEASE_DIR}/var ${RELEASE_DIR}/vendor ${RELEASE_DIR}/pub/static ${RELEASE_DIR}/pub/media ${RELEASE_DIR}/app/etc -type f -exec chmod u+w {} \;

logvalue "Setting file permissions:"
#find ${RELEASE_DIR}/var ${RELEASE_DIR}/vendor ${RELEASE_DIR}/pub/static ${RELEASE_DIR}/pub/media ${RELEASE_DIR}/app/etc -type d -exec chmod u+w {} \;

logvalue "Setting directory permissions:"
#chmod u+x ${RELEASE_DIR}/bin/magento
#chmod -R 775 ${RELEASE_DIR}/var
