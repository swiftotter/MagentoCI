#!/bin/bash

### 5-composer-check.sh: this file checks to ensure composer is installed and available with the "composer" alias.

if ! type "composer" > /dev/null; then
  logvalue "Composer not installed. Quitting."
  exit 3
fi
