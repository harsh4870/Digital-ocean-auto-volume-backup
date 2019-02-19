# Digital-ocean-auto-volume-backup
Digital ocean auto volume backup shell script.Currently, it will keep 2 newest snapshots. If you want to config this, change the value.

# What does this script do ?
Since DigitalOcean currently didn't provide auto backup for the volume. So, i created the script to call DigitalOcean API and creating volume's snapshot. After successfully created, it will delete the old snapshot.

Currently, it will keep 2 newest snapshots. If you want to config this, change the value.

Digital ocean API documentation : https://developers.digitalocean.com/documentation/v2/#introduction

## Dependency
./jq library

Download from : https://stedolan.github.io/jq/

Linux : sudo apt-get install jq

## Script use : 

Config your parameter in snapshot.sh

Set cronjob to execute snapshot.sh

## Parameter : 

DIGITALOCEAN_TOKEN
VOLUME_ID
VOLUME_NAME
SNAPSHOT_NAME
DATE

## List Down all volumes without jq
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ADD YOUR DIGITAL TOKEN HERE "https://api.digitalocean.com/v2/volumes?region=blr1"

Note : Don't forget to change region in httpsrequest

Get Volume_Name & Volume_Id

Region Name : https://www.digitalocean.com/docs/platform/availability-matrix/

## Parse json in terminal using ./jq
curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ADD YOUR DIGITAL TOKEN HERE " "https://api.digitalocean.com/v2/volumes?region=blr1" | jq '.' | cat

Note : Don't forget to change region in httpsrequest

Get Volume_Name & Volume_Id

Region Name : https://www.digitalocean.com/docs/platform/availability-matrix/
