#!/usr/bin/env bash
set -eou pipefail

sync() {
    ORIGIN=$1
    NEWNAME=$ORIGIN
    NEWNAME=${NEWNAME/gcr.io\//cncr*}
    NEWNAME=${NEWNAME//\//-}
    NEWNAME=${NEWNAME/\*/\/}

    echo "docker pull $IMAGE && docker tag $IMAGE $NEWNAME && docker push $NEWNAME"
    docker pull $IMAGE && docker tag $IMAGE $NEWNAME && docker push $NEWNAME
}

IFS=$'\n'
for IMAGE in $(cat ./IMAGES) ; do
    sync $IMAGE
done
