#!/bin/bash

if [ ! -e assets ]; then
  mkdir assets
fi

VER_NO=1.3
ARCHIVE_FILE=linux-release-${VER_NO}.zip
SRC_URL="https://github.com/aws-samples/appstream-serverless-image-creation-automation/releases/download/v${VER_NO}/${ARCHIVE_FILE}"

cd assets
curl -JLO "$SRC_URL"
unzip ${ARCHIVE_FILE} && rm ${ARCHIVE_FILE}
cd -

