#!/bin/bash

set -eu

ACCOUNT_PATH=$(buildkite-agent meta-data get directory)

## By doing this we can dynamically add more steps to the build
PIPELINE="
steps:
  - label: ':building_construction: $ACCOUNT_PATH'
    command: |
      echo 'terraform plan'
      bash \${DIRECTORY}/main.sh
    branches: '*'
    agents:
      - 'queue=testing'
    env:
      DIRECTORY: $ACCOUNT_PATH
  
  - wait
  
  - label: ':city_sunrise: $ACCOUNT_PATH'
    command: |
      echo 'terraform apply'
      bash \${DIRECTORY}/main.sh
    branches: '*'
    agents:
       - 'queue=testing'
    env:
      DIRECTORY: $ACCOUNT_PATH
"

echo "$PIPELINE"

echo "$PIPELINE" | buildkite-agent pipeline upload