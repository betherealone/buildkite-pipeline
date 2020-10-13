#!/bin/bash

set -eu

ACCOUNT_PATH=$(buildkite-agent meta-data get directory)

## By doing this we can dynamically add more steps to the build
PIPELINE="
steps:
  - label: ':building_construction: $ACCOUNT_PATH'
    command: |
      echo 'terraform plan'
      make plan
    branches: '*'
    agents:
      queue: "${BUILDKITE_AGENT_META_DATA_QUEUE:-testing}"
    env:
      ACCOUNT_PATH: $ACCOUNT_PATH
  
  - wait: ~
    continue_on_failure: false
  
  - label: ':city_sunrise: $ACCOUNT_PATH'
    command: |
      echo 'terraform apply'
      make apply
    branches: '*'
    agents:
       queue: "${BUILDKITE_AGENT_META_DATA_QUEUE:-testing}"
    env:
      ACCOUNT_PATH: $ACCOUNT_PATH
"

echo "$PIPELINE"

echo "$PIPELINE" | buildkite-agent pipeline upload