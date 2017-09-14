#!/bin/bash

### 99-warm-opcache.sh: this triggers a curl call to the HTTP path

logvalue "Curling the website to warm caches."

if [ -n ${HTTP_PATH} == "" ]; then
    curl -I ${HTTP_PATH}
fi
