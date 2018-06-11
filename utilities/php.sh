#!/usr/bin/env bash

if [ -x "$(command -v php72)" ]; then
  PHP="php72"
elif [ -x "$(command -v php71)" ]; then
  PHP = "php71";
elif [ -x "$(command -v php70)" ]; then
  PHP = "php70";
else
  PHP = "php";
fi

export PHP=$PHP
