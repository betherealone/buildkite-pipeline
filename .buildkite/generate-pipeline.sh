#!/bin/bash

set -euo pipefail

# Set up a variable to hold the meta-data from your block step
RELEASE_TYPE="$(buildkite-agent meta-data get "release-type")"

# RELEASE_TYPE="prod"

echo "---"
echo -e '\033[0;35m'
echo "$RELEASE_TYPE"
echo
echo -e '\033[0m'
echo "---"

PIPELINE="steps:
  - label: \"release-type\"
    command: echo.sh
    agents:
    - "queue=testing"
    env:
      RELEASE_TYPE: $RELEASE_TYPE
"

echo "$PIPELINE" | buildkite-agent pipeline upload