#! /bin/sh

set -e

if [ "$1" = "--help" ]; then
    echo "./process-component.sh [env]"
    exit
fi

env=$1

# get component names

cd components
components=$(ls -1)
cd ..

# process each component

for component in $components; do
    ./process-component.sh $component $env
done
