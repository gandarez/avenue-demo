#!/bin/bash

set -e

# ensure existence of release folder
if ! [ -d "./release" ]; then
    mkdir ./release
fi

# ensure zip is installed
if [ "$(which zip)" = "" ]; then
    apt-get update && apt-get install -y zip
fi

# add execution permission
chmod 750 ./build/avenue-demo-linux-amd64

# create archives
zip -j ./release/avenue-demo-linux-amd64.zip ./build/avenue-demo-linux-amd64

# calculate checksums
for file in  ./release/*; do
	checksum=$(sha256sum ${file} | cut -d' ' -f1)
	filename=$(echo ${file} | rev | cut -d/ -f1 | rev)
	echo "${checksum} ${filename}" >> ./release/checksums_sha256.txt
done
