#!/bin/bash

# usage of script:
# ./build.sh 4.8.1 trainemize/nuget-exe
nuget_version=${1}
image_name=${2}

# check if a valid version was provided
if [[ -z ${nuget_version} ]] || [[ ! ${nuget_version} =~ ^[0-9]+.[0-9]+.[0-9]+$ ]] ; then
    echo "error: first param has to be the version of nuget.exe (in semver style)"
    exit 1;
fi

# check which image name was provided
if [[ -z ${image_name} ]]; then
    echo "info: no image name was provided, will use default instead"
    echo "------------"
    image_name=trainemize/nuget-exe
fi

# input summary
echo "nuget.exe version: ${nuget_version}"
echo "image name: ${image_name}"

# build the image
docker build -t ${image_name}:${nuget_version} --build-arg NUGET_VERSION=${nuget_version} .
docker tag ${image_name}:${nuget_version} ${image_name}:latest