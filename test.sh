#!/bin/bash

## Executes all build instructions

usage="$(basename "$0") [-s] [-b] [-h] [-i] -- test script.

where:
    -h|--help show the help text
    -i|--buildID Build ID (REQUIRED)
    -c|--cryptKey Crypt key (REQUIRED)
    -b|--s3Bucket S3 bucket (REQUIRED)
    -f|--dbFile DB File in S3 bucket (REQUIRED)
    -p|--filePath Path (REQUIRED)
    -d|--debug Debug mode
    -t|--tablePrefix Table prefix
    -m|--magentoVersion Version of Magento deployed

To run this script, you must be in the folder that contains the deploy destination (current), the permanent assets folder (link) and the releases (releases) folder. These folders will be attempted to be created if they do not exist."

DEBUG=0



while [[ $# -gt 1 ]]
do
key="$1"

case $key in 
    -i|--buildID)
    BUILD_ID=$2
    shift
    ;;
    -i|--magentoVersion)
    MAGENTO_VERSION=$2
    shift
    ;;
    -c|--cryptKey)
    CRYPT_KEY=$2
    shift
    ;;
    -t|--tablePrefix)
    TABLE_PREFIX=$2
    shift
    ;;
    -b|--s3Bucket)
    S3_BUCKET=$2
    shift
    ;;
    -p|--filePath)
    FILE_PATH=$2
    shift
    ;;
    -f|--dbFile)
    DB_FILE=$2
    shift
    ;;
    -d|--debug)
    DEBUG=$2
    shift
    ;;
    -h|--help)
    echo "$usage"
    exit
    shift
    ;;
    *)
    ;;
esac
shift
done

if [ -z ${BUILD_ID+x} ]; then
    echo "You must specify the build id (-b)."
    exit 125
fi

if [ -z ${CRYPT_KEY+x} ]; then
    echo "You must specify the crypt key (-c)."
    exit 125
fi

if [ -z ${S3_BUCKET+x} ]; then
    echo "You must specify the S3 Bucket to load the DB from (-b)."
    exit 125
fi

if [ -z ${FILE_PATH+x} ]; then
    echo "You must specify the path to this file (excluding the home directory and the workspace folder) (-p)."
    exit 125
fi

if [ -z ${DB_FILE+x} ]; then
    echo "You must specify the file to load the DB from (-f)."
    exit 125
fi

if [ -z ${TABLE_PREFIX+x} ]; then
    TABLE_PREFIX=""
else
    TABLE_PREFIX=${TABLE_PREFIX%_}"_"
fi

export DEBUG=${DEBUG}
export FILE_PATH=${FILE_PATH}
export CRYPT_KEY=${CRYPT_KEY}
export S3_BUCKET=${S3_BUCKET}
export DB_FILE=${DB_FILE}
export TABLE_PREFIX=${TABLE_PREFIX}
export ENVIRONMENT=${ENVIRONMENT}
export MAGENTO_VERSION=${MAGENTO_VERSION}

printf "Debug Mode: ${DEBUG}\n"

export TESTMODE=1
source scripts/build.sh -n

source "scripts/utilities/include.sh"
source "scripts/utilities/php.sh"

directoryiterator "scripts/test"