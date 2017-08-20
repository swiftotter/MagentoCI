#!/bin/bash

## Executes all build instructions

usage="$(basename "$0") [-s] [-b] [-h] [-i] -- deploy script.

where:
    -h show the help text
    -b Build number. The number of the build. REQUIRED.
    -d Debug mode. Prompts before proceeding to script.
    -u Owner user.
    -g Owner group.
    -e Environment
    -i Build id (ex: build-24)


To run this script, you must be in the folder that contains the deploy destination (current), the permanent assets folder (link) and the releases (releases) folder. These folders will be attempted to be created if they do not exist."

DEBUG=0

while [[ $# -gt 1 ]]
do
key="$1"

case $key in 
    -b|--build)
    BUILD=$2
    shift
    ;;
    -m|--magentoVersion)
    MAGENTO_VERSION=$2
    shift
    ;;    
    -i|--buildID)
    BUILD_ID=$2
    shift
    ;;
    -e|--environment)
    ENVIRONMENT=$2
    shift
    ;;
    -u|--user)
    USER=$2
    shift
    ;;
    -g|--group)
    GROUP=$2
    shift
    ;;
    -d|--deployUser)
    DEPLOY_USER=$2
    shift
    ;;
    -g|--debug)
    DEBUG=$2
    shift
    ;;
    -h|--help)
    echo "$usage"
    exit
    ;;
    *)
    ;;
esac
shift
done

if [ -z ${BUILD+x} ]; then
    echo "You must specify the build number (-b)."
    exit 125
fi

if [ -z ${BUILD_ID+x} ]; then
    BUILD_ID="build-${BUILD}"
fi

if [ -z ${USER+x} ]; then
    USER="apache"
fi

if [ -z ${GROUP+x} ]; then
    GROUP="apache"
fi

if [ -z ${DEPLOY_USER+x} ]; then
    DEPLOY_USER=${USER}
fi

if [ -z ${DEBUG+x} ]; then
    DEBUG=0
fi

if [ -z ${USE_SUDO+x} ]; then
    USE_SUDO=0
fi

if [ -z ${MAGENTO_VERSION+x} ]; then
    MAGENTO_VERSION="2.2"
fi

export DEBUG=${DEBUG}
export BUILD=${BUILD}
export ENVIRONMENT=${ENVIRONMENT}
export BUILD_ID=${BUILD_ID}
export USER=${USER}
export GROUP=${GROUP}
export DEPLOY_USER=${DEPLOY_USER}
export MAGENTO_VERSION=${MAGENTO_VERSION}

printf "Debug Mode: ${DEBUG}"

source "releases/${BUILD_ID}/scripts/utilities/include.sh"
source "releases/${BUILD_ID}/scripts/utilities/php.sh"

directoryiterator "releases/${BUILD_ID}/scripts/deploy"
