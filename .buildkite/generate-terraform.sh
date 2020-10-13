#!/bin/bash

set -eu

ACCOUNT_PATH=$(buildkite-agent meta-data get directory)

## By doing this we can dynamically add more steps to the build
PIPELINE="
steps:
  - label: ':building_construction: $ACCOUNT_PATH'
    command: |
      echo 'terraform plan'
      bash main.sh
    branches: "*"
    agents:
      - 'queue=testing'
    env:
      ACCOUNT_PATH: $ACCOUNT_PATH
  
  - label: ':city_sunrise: $ACCOUNT_PATH'
    command: |
      echo 'terraform apply'
      bash main.sh
    branches: "*"
    agents:
       - 'queue=testing'
    env:
      ACCOUNT_PATH: $ACCOUNT_PATH
"

echo "$PIPELINE"

echo "$PIPELINE" | buildkite-agent pipeline upload