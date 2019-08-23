#!/bin/bash

## Executes all build instructions

usage="$(basename "$0") [-s] [-b] [-h] [-i] -- test script.

where:
    -h|--help show the help text
    -d|--debug Debug mode

To run this script, you must be in the folder that contains the deploy destination (current), the permanent assets folder (link) and the releases (releases) folder. These folders will be attempted to be created if they do not exist."

DEBUG=0

currentDirectory=$(pwd)

while [[ $# -gt 1 ]]
do
key="$1"

case $key in 
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

export DEBUG=${DEBUG}
printf "Debug Mode: ${DEBUG}\n"

export TESTMODE=1

source "scripts/utilities/include.sh"
source "scripts/utilities/php.sh"

directoryiterator "scripts/unit-test"
