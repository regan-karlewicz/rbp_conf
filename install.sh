#!/bin/bash

for dir in */; do
    if [ -f "$dir/install.sh" ]; then
        echo "Running install.sh in $dir..."
        (cd "$dir" && ./install.sh)
    fi
done
