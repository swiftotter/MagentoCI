#!/bin/bash

### 99-warm-opcache.sh: this triggers a curl call to the HTTP path

logvalue "Curling the website to warm caches: ${HTTP_PATH}"

if [ ${#HTTP_PATH} -ge 1 ]; then
#    logvalue "Executing cURL: ${HTTP_PATH}"
#    curl -I ${HTTP_PATH}
fi
