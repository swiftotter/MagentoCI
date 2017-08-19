#!/bin/bash

## Executes all build instructions

if [ "$(uname)" == "Darwin" ]; then ## MAC
    for folder in `find -E scripts/build -type d  -regex "scripts/build/[0-9]{1,3}-.+" | sort -g -k1.15`; do
        for file in `find -E ${folder]} -type f -regex "[0-9]{1,3}-.+\.sh" | sort -g -k1.15`; do
            printf "\n\nRunning ${file}\n"
            source $file
        done
    done
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    for folder in `find scripts/build -type d -regextype posix-extended -regex "scripts/build/[0-9]{1,3}-.+" | sort -g -k1.15`; do
        for file in `find -E ${folder]} -type f -regex "[0-9]{1,3}-.+\.sh" | sort -g -k1.15`; do
            printf "\n\nRunning ${file}\n"
            source $file
        done
    done
fi