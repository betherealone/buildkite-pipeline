#!/bin/bash

# This dynamically generates a pipeline containing a click to unblock step with
# custom fields.

set -eu

# Separate account lists
abc=$(find org/management -maxdepth 3 -mindepth 3 -type d | sort)

xyz=$(find org/spoke -maxdepth 3 -mindepth 3 -type d | sort)

result=("${abc[@]}" "${xyz[@]}")

sorted_unique_ids="$(echo "${result[*]}" | tr ' ' '\n' | sort -u )"

## Collect all them to a single list

echo 'steps:'
echo '  - block: "Notify"'
echo '    fields:'
echo '      - select: "Which Directory should be deployed?"'
echo '        key: "directory"'
echo '        options:'

for option in $sorted_unique_ids; do
echo "          - "$option""
done