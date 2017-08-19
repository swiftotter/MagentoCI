#!/bin/bash

case $SSH_ORIGINAL_COMMAND in
    'scp'*)
        $SSH_ORIGINAL_COMMAND
        ;;
    *)
        if [ ${DEPLOY_ENV} != "prod" ] && [ ${DEPLOY_ENV} != "dev" ]; then
           DEPLOY_ENV="dev"
        fi

        if [ ! -z ${TARGET} ] && [ ! -z ${BUILD} ] && [ ! -z ${RELEASE} ] && [ ! -z ${DEPLOY_ENV} ]; then
            cd ${TARGET}/${DEPLOY_ENV}/
            echo "cd ${TARGET}/${DEPLOY_ENV}/"
            echo "Executing deploy of ${RELEASE}"

            if [ ! -d releases/${RELEASE} ]; then
                echo "Extracting release into: releases/${RELEASE}"
                mkdir -p releases/${RELEASE}
                tar -xzf releases/${RELEASE}.tar.gz -C releases/${RELEASE}
            fi

            ./releases/${RELEASE}/scripts/deploy.sh -e "ENVIRONMENT" -b "${BUILD}" -i "${RELEASE}"
        else
            echo "Unable to execute deploy. The BUILD or RELEASE variable is not set."
        fi
        ;;
esac