#!/bin/bash

## Executes all build instructions
directoryiterator() {
    path=$1
    regex_flag="-regextype posix-extended"
    processed=0

    if [ "$(uname)" == "Darwin" ]; then
        regex_flag="-E"
    fi

    for folder in `find ${path} -type d ${regex_flag} -regex "${path}/[0-9]{1,3}-.+" | sort -g -k1.15`; do
        printf "\nProcessing ${folder}\n"
        processed=1
        
        if [[ ${folder} == *"-m2"* ]] && [[ ${MAGENTO_VERSION} != "2."* ]]; then
            continue
        fi
    
        if [[ ${folder} == *"-m1"* ]] && [[ ${MAGENTO_VERSION} != "1."* ]]; then
            continue
        fi
        
        fileiterator ${folder}
    done

    if [ $processed == 0 ]; then
        printf "\nNo folders found in ${path}"
    fi
}


###
# Iterates through available folders.
# 1: The file to execute
fileiterator() {
    folder=$1
    scope=$2
    processed=0
    DECISION="y"

    if (( ${DEBUG:-0} >= 1 )); then
        echo "  Do you want to execute the ${folder} folder? Y/n"
        read DECISION
    fi

    if [ ${folder} == *"DISABLED"* ] || [[ ${DECISION} == *"n"* ]]; then
        printf "\n  >> Skipping FOLDER ${folder}\n"
        exit
    fi
    
    for file in `find ${folder} -type f ${regex_flag} -regex "${folder}/[0-9]{1,3}-.+\.sh" | sort -g -k1.15`; do
        if [[ ${file} == *"-m2"* ]] && [[ ${MAGENTO_VERSION} != "2."* ]]; then
            continue
        fi
    
        if [[ ${file} == *"-m1"* ]] && [[ ${MAGENTO_VERSION} != "1."* ]]; then
            continue
        fi
        
        runfile ${file} ${scope}
        processed=1
    done

    if [ $processed == 0 ]; then
        printf "\n  No folders found in ${path}"
    fi
}

runfile() {
    file=$1
    scope=$2

    if (( "${DEBUG:-0}" >= 1 )); then
        echo "    Do you want to execute the ${file} file?"
        read DECISION
    fi

    if [ ${file} == *"DISABLED"* ] || [[ ${DECISION} == *"n"* ]]; then
        printf "\n    >> Skipping FILE ${file}\n"
        exit
    fi
    
    printf "\n\n${DESCRIPTOR_INDENT}Running ${file}\n"
    if [ -z "${scope}" ]; then
       source $file
       
       local RESULT=$?
       if [ $RESULT -ne 0 ] && [ $RESULT -ne 255 ]; then
         exit 1
       fi
    else
        (cd ${scope} && source $file)
        if [ $? -ne 0 ]; then # If: last exit code is non-zero
          exit 1
        fi
    fi
}
