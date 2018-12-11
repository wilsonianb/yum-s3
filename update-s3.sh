#!/bin/bash

set -e

if [ -z "${SOURCE_DIR}" ]; then
  echo "Source directory must be specified."
  exit 1
fi

if [ -z "${S3_DIR}" ]; then
  echo "S3 directory must be specified."
  exit 1
fi

TARGET_DIR="/tmp/${S3_DIR}"

# make sure we're operating on the latest data in the target bucket
mkdir -p $TARGET_DIR
aws s3 sync "s3://${S3_DIR}" $TARGET_DIR

# copy the RPM in and update the repo
mkdir -pv $TARGET_DIR/
cp -rv $SOURCE_DIR/* $TARGET_DIR
UPDATE=""
if [ -e "$TARGET_DIR/repodata/repomd.xml" ]; then
  UPDATE="--update "
fi
createrepo -v $UPDATE --deltas $TARGET_DIR/

# sync the repo state back to s3
aws s3 sync $TARGET_DIR s3://$S3_DIR --acl public-read
