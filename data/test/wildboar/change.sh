#!/bin/bash

# Process each label file in the "labels" folder
for file in labels/*.txt; do
    awk 'NR==FNR {map[$1]=$2; next} {if ($1 in map) $1 = map[$1]; print}' mapping.txt "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done

