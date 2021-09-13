#! /bin/sh

set -e

if [ -z $1 ]; then
    echo "error: component must be defined"
    exit 1
elif [ $1 = "--help" ]; then
    echo "./process-component.sh component [env]"
    exit
fi

component=$1

if [ ! -z $2 ]; then
    env=$2
fi

# prepare target dir

mkdir -p target/vars/$component
mkdir -p target/components/$component

# if we have includes we must add those default vars before component vars

cd components/$component
included_components=$(grep -rE '{%\s*include' . | awk '{print $3}' | sed "s/\'//g" | sed 's/\"//g' | cut -d '/' -f 1)
cd ../..

vars=""

for included_component in $included_components; do
    vars="${vars} vars/${included_component}/vars.yaml"
done

vars="${vars} vars/${component}/vars.yaml"
if [ ! -z $env ]; then
    vars="${vars} vars/${component}/vars-${env}.yaml"
fi

# merge all vars

cmd=$(echo "docker run --rm -w /app -v ${PWD}:/app boxboat/config-merge:0.2.2 ${vars}")

$cmd > target/vars/${component}/vars.yaml

# render component

cd components

cd $component
templates=$(ls -1)
cd ..

for template in $templates; do
    j2 $component/$template ../target/vars/$component/vars.yaml > ../target/components/$component/$template
done

cd ..
