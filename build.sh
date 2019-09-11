#!/usr/bin/env bash
usage="\n$(basename "$0") [-d|--debug] [-m|--magentoVersion] [-t|--theme] [-b|--buildID] -- deploy script.\n
\n
where:
    -h show the help text\n
    -d|--debug Debug mode. Prompts before proceeding to script.\n
    -m|--magentoVersion Magento version (at least specify 1 or 2).\n
    -t|--theme Theme to be compiled. Blank for no compilation.\n
    -b|--buildID Build number (placed in file: app/design/build)\n\n

ENVIRONMENT VARIABLES:\n
    MYSQL_USER (default: root)\n
    MYSQL_PASSWORD (default: [[empty]])\n\n

To run this script, you must be in the folder that contains a scripts/ folder (where this file is stored), and a src/ folder."

DEBUG=0
THEME=""

while [[ $# -gt 1 ]]
do
key="$1"

case $key in 
    -d|--debug)
    DEBUG=1
    shift
    ;;
    -h|--help)
    echo "$usage"
    exit
    shift
    ;;
    -m|--magentoVersion)
    MAGENTO_VERSION="$2"
    shift
    ;;
    --mysqlHost)
    MYSQL_HOST="$2"
    shift
    ;;
    -t|--theme)
    THEME="$2"
    shift
    ;;
    -b|--buildID)
    BUILD_ID="$2"
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
    -c|--commit)
    COMMIT=$2
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
    *)
    ;;
esac
shift
done

if [ -z ${MYSQL_HOST+x} ]; then
    MYSQL_HOST="127.0.0.1"
fi

if [ -z ${MAGENTO_VERSION+x} ]; then
    MAGENTO_VERSION="2.2"
fi

if [ -z ${THEME+x} ]; then
    THEME="flow"
fi

if [ -z ${DEBUG+x} ]; then
    DEBUG=0
fi

export DEBUG=${DEBUG}
export THEME=${THEME}
export MYSQL_HOST=${MYSQL_HOST}
export MAGENTO_VERSION=${MAGENTO_VERSION}
export BUILD_ID=${BUILD_ID}

# Include the directory iterator function
source scripts/utilities/include.sh
source scripts/utilities/php.sh

if [ ! -z "$SENTRY_ORG" ]; then
curl https://sentry.io/api/0/organizations/${SENTRY_ORG}/releases/ \
  -X POST \
  -H 'Authorization: Bearer '${SENTRY_TOKEN} \
  -H 'Content-Type: application/json' \
  -d '{"version": "'${PIPELINE_ID}'","id": "'${PIPELINE_ID}'","refs":[{"commit":"'${COMMIT}'","repository":"'${REPOSITORY}'"}],"projects":["'${SENTRY_PROJECT_SLUG}'"]}'
fi

directoryiterator "${BASE_PATH}/scripts/build"
