#!/usr/bin/env bash

PHP="php71"
php71 -i >/dev/null 2>&1 || { PHP="php70"; }
php70 -i >/dev/null 2>&1 || { PHP="php"; }

export PHP=$PHP