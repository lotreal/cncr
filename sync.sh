#!/usr/bin/env bash
read -r -d '' IMAGES <<- EOM
gcr.io/spinnaker-marketplace/clouddriver:2.0.0-20180221152902
gcr.io/spinnaker-marketplace/echo:0.8.0-20180221133510
gcr.io/spinnaker-marketplace/deck:2.1.0-20180221143146
gcr.io/spinnaker-marketplace/igor:0.9.0-20180221133510
gcr.io/spinnaker-marketplace/orca:0.10.0-20180221133510
gcr.io/spinnaker-marketplace/gate:0.10.0-20180221133510
gcr.io/spinnaker-marketplace/front50:0.9.0-20180221133510
gcr.io/spinnaker-marketplace/rosco:0.5.0-20180221133510
EOM

rename() {
    ORIGIN=$1
    NEWNAME=$ORIGIN
    NEWNAME=${NEWNAME/gcr.io\//cncr*}
    NEWNAME=${NEWNAME//\//-}
    NEWNAME=${NEWNAME/\*/\/}

    echo "docker pull $IMAGE && docker tag $IMAGE $NEWNAME && docker push $NEWNAME"
    docker pull $IMAGE && docker tag $IMAGE $NEWNAME && docker push $NEWNAME
}

for IMAGE in $IMAGES
do
    rename $IMAGE
done
