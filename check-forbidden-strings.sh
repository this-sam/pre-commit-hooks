#!/bin/bash

echo "Running check-forbidden-strings pre-commit hook" 
checks=('@testit') # create an array

# Check to see if the forbidden string(s) are in the changes before committing.
git diff --name-status | while read flag file; do
    if [ "$flag" == 'D' ]; then continue; fi

    for word in ${checks[@]}
    do
        if egrep -q "$word" "$file"; then
            echo "ERROR: Disallowed expression \"${word}\" in file: ${file}" >&2
            exit 1
        fi
    done
done