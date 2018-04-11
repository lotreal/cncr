#!/usr/bin/env bash
set -eou pipefail

IMAGES=$(gcloud container images list --repository=gcr.io/spinnaker-marketplace --format=json | jq -r ".[].name")

echo "" > ./IMAGES
for IMAGE_NAME in ${IMAGES} ; do
    FILTER="def join(tag): \"${IMAGE_NAME}:\" + tag; map(join(.tags[])) | .[]"
    gcloud container images list-tags ${IMAGE_NAME} --limit=3 --format=json | jq -r "$FILTER" >> ./IMAGES
done
