#!/bin/bash

### 99-warm-opcache.sh: this triggers a curl call to the HTTP path

logvalue "Curling the website to warm caches."

if [[ ${HTTP_PATH} == "" ]] || [[ -z ${HTTP_PATH+x} ]]; then
else
    curl -I ${HTTP_PATH}
fi
