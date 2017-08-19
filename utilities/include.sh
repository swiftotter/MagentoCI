#!/usr/bin/env bash

base=$(pwd)
base=${base%/}
export BASE_PATH=$base

export DESCRIPTOR_INDENT="  - "
export FILE_INDENT="     - "

source "${BASH_SOURCE%/*}/directory-iterator.sh"

logvalue() {
    printf "${FILE_INDENT}${1}\n"
}