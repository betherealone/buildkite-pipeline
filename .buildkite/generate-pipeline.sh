#!/bin/bash

set -euo pipefail

# Set up a variable to hold the meta-data from your block step
RELEASE_NAME="$(buildkite-agent meta-data get "release-type")"

# Create a pipeline with your trigger step
PIPELINE="steps:
  - label: ":pencil: echo release-type"
    command: echo "agent $RELEASE_TYPE"
    agents:
      - "queue=testing"
    env:
      RELEASE_TYPE: $(buildkite-agent meta-data get release-type)
"
echo "$PIPELINE" | buildkite-agent pipeline upload