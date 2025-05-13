#!/bin/bash
#
#HOSTNAME="${1}"

#curl "${HOSTNAME}"

API_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI4YjZhNzQzM2FmMjg0ZjkxOGQxOWI4YmRiOTc0NGRiZiIsImlhdCI6MTczMzQ5NDk0NywiZXhwIjoyMDQ4ODU0OTQ3fQ.O1pXP9jZp1eifyXd0FBtoG8SpnsBx2od8CQ3HeeTwJg"
SENSOR_ENTITY_ID="sensor.bluetooth_proxy_desk_esphome_version"
HOSTNAME="https://zfy8zk5d89ouqfkkke1mwy65ub3ntbui.ui.nabu.casa"


FULL_VERSION="$(curl -s -H "Authorization: Bearer ${API_TOKEN}" "${HOSTNAME}/api/states/${SENSOR_ENTITY_ID}" | jq -r '.state')"

#echo "${FULL_VERSION}" |  awk '{print $1}'
VERSION="$(echo "${FULL_VERSION}" |  cut -d\  -f1)"
VERSION_DATE="$(echo "${FULL_VERSION}" |  cut -d\  -f2-)"

echo "FULL_VERSION=${FULL_VERSION}"
echo "VERSION=${VERSION}"
echo "VERSION_DATE=${VERSION_DATE}"

