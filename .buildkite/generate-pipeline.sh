#!/bin/bash

set -euo pipefail

# Set up a variable to hold the meta-data from your block step
RELEASE_TYPE="$(buildkite-agent meta-data get "release-type")"

# Create a pipeline with your trigger step
PIPELINE="steps:
  - trigger: \"deploy-pipeline\"
    label: \"Trigger deploy\"
    build:
      meta_data:
        release-type: $RELEASE_TYPE
  - label: ":pencil: echo release-type"
    command: echo "agent $RELEASE_TYPE"
    agents:
      - "queue=testing"
    env:
      RELEASE_TYPE: $RELEASE_TYPE
"
echo "$PIPELINE" | buildkite-agent pipeline upload