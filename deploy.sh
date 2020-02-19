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
    -h|--httpPath)
    HTTP_PATH=$2
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
    --php)
    PHP_EXEC=$2
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
    -r|--rollbar)
    ROLLBAR=$2
    shift
    ;;
    -c|--commit)
    COMMIT=$2
    shift
    ;;
    --sentryOrg)
    SENTRY_ORG="$2"
    shift
    ;;
    --sentryProjectSlug)
    SENTRY_PROJECT_SLUG="$2"
    shift
    ;;
    --sentryToken)
    SENTRY_TOKEN="$2"
    shift
    ;;
    --repository)
    REPOSITORY=$2
    shift
    ;;
    --pipelineID)
    PIPELINE_ID=$2
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
export HTTP_PATH=${HTTP_PATH}
export PHP_EXEC=${PHP_EXEC}

printf "Debug Mode: ${DEBUG}"

source "releases/${BUILD_ID}/scripts/utilities/include.sh"
source "releases/${BUILD_ID}/scripts/utilities/php.sh"

if [ ! -z "$ROLLBAR" ]; then
    curl --request POST \
        --url https://api.rollbar.com/api/1/deploy/ \
        --header 'content-type: application/json' \
        --data '{"access_token":"'${ROLLBAR}'","environment":"'${ENVIRONMENT}'","revision":"'${COMMIT}'","status":"started"}'
fi

directoryiterator "releases/${BUILD_ID}/scripts/deploy"

if [ ! -z "$ROLLBAR" ]; then
    curl --request POST \
        --url https://api.rollbar.com/api/1/deploy/ \
        --header 'content-type: application/json' \
        --data '{"access_token":"'${ROLLBAR}'","environment":"'${ENVIRONMENT}'","revision":"'${COMMIT}'","status":"succeeded"}'
fi

if [ ! -z "$SENTRY_ORG" ]; then
    set -x
    curl https://sentry.io/api/0/organizations/${SENTRY_ORG}/releases/${PIPELINE_ID}/deploys/ \
        -X POST \
        -H 'Authorization: Bearer '${SENTRY_TOKEN} \
        -H 'Content-Type: application/json' \
        -d '{"environment":"'${ENVIRONMENT}'","name":"'${PIPELINE_ID}'"}'
    set +x
fi
