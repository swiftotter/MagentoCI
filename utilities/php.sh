#!/usr/bin/env bash

if [ -n "$PHP_EXEC" ] && [ -x "$(command -v $PHP_EXEC)" ]; then
  PHP="$(command -v $PHP_EXEC)"
elif [ -x "$(command -v php73)" ]; then
  PHP="$(command -v php73)"
elif [ -x "$(command -v php72)" ]; then
  PHP="$(command -v php72)"
elif [ -x "$(command -v php71)" ]; then
  PHP="$(command -v php71)"
elif [ -x "$(command -v php70)" ]; then
  PHP="$(command -v php70)"
else
  PHP="$(command -v php)"
fi

echo "PHP executable is: " ${PHP}

export PHP=$PHP
