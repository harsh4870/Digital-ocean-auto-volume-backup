#!/bin/bash

DIGITALOCEAN_TOKEN='7bc0c4cafd4c6db31a799aad1c447471b7cfaf2558491837592d72ca4e7d5db1'
SNAPSHOT_NAME='Snap'

DATE=`date '+%Y%m%d-%H%M%S'`

TOTAL_SNAPSHOTS=$(curl "https://api.digitalocean.com/v2/volumes?region=blr1" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" )

for j in {0..4};
do
	VOLUME_ID=$(echo "$TOTAL_SNAPSHOTS" | jq ".volumes[$j].id" | sed "s/\"//g")
	VOLUME_NAME=$(echo "$TOTAL_SNAPSHOTS" | jq ".volumes[$j].name" | sed "s/\"//g")
	curl -X POST \
   "https://api.digitalocean.com/v2/volumes/$VOLUME_ID/snapshots" \
   -H "authorization: Bearer $DIGITALOCEAN_TOKEN" \
   -H 'cache-control: no-cache' \
   -H 'content-type: application/json' \
   -d "{
   \"name\": \"$VOLUME_NAME-$DATE\"
 }"
    VOLUME_ID=""
    VOLUME_NAME=""
    sleep 2m
done

OLD_SNAPSHOTS=$(curl https://api.digitalocean.com/v2/snapshots?resource_type=volume \
-H "authorization: Bearer $DIGITALOCEAN_TOKEN" -H 'cache-control: no-cache' \
-H 'content-type: application/json' | jq ".snapshots|sort_by(.created_at)[:-4][] | .id" | sed "s/\"//g")

for SNAPSHOT_ID in $OLD_SNAPSHOTS
do
    curl -X DELETE -H 'Content-Type: application/json' \
    -H "authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/snapshots/$SNAPSHOT_ID"
done
