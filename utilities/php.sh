#!/usr/bin/env bash

if [ -n $PHP_EXEC ]; then
  PHP=$PHP_EXEC
elif [ -x "$(command -v php73)" ]; then
  PHP="php73"
elif [ -x "$(command -v php72)" ]; then
  PHP="php72"
elif [ -x "$(command -v php71)" ]; then
  PHP="php71"
elif [ -x "$(command -v php70)" ]; then
  PHP="php70"
else
  PHP="php"
fi

echo "PHP executable is: " ${PHP}

export PHP=$PHP
