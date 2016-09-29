#!/bin/bash

set -eu

BUCKET_NAME="${SIMPLEREPO_BUCKET_NAME:-simplerepo}"

if ! type createrepo 2>/dev/null
then
  docker build -t simplerepo .
fi

mkdir -p target

pushd target

aws s3 sync --delete "s3://${BUCKET_NAME}/Packages" Packages
aws s3 sync --delete "s3://${BUCKET_NAME}/repodata" repodata

if type createrepo 2>/dev/null
then
  createrepo .
else
  docker run --rm -v "${PWD}:/simplerepo" simplerepo
fi

aws s3 sync --delete . "s3://${BUCKET_NAME}"

popd
