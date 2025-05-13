#!/bin/bash
#
#
#
#

LOG_DIR="${HOME}/out"
LOG_FILE="${LOG_DIR}/update_all-$(date -I).out"

API_TOKEN="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI4YjZhNzQzM2FmMjg0ZjkxOGQxOWI4YmRiOTc0NGRiZiIsImlhdCI6MTczMzQ5NDk0NywiZXhwIjoyMDQ4ODU0OTQ3fQ.O1pXP9jZp1eifyXd0FBtoG8SpnsBx2od8CQ3HeeTwJg"
HOSTNAME="https://zfy8zk5d89ouqfkkke1mwy65ub3ntbui.ui.nabu.casa"

SANITY="false"
#SANITY="true"

if [[ ! -e "${LOG_DIR}" ]]; then
	mkdir -p "${LOG_DIR}"
fi

echo "Starting at $(date)" >> ${LOG_FILE}

OLD_VERSION="$(esphome version|cut -d\  -f2)"
cd $HOME/esphome
#pip install --upgrade pip >> ${LOG_FILE}
#pip3 install esphome -U >> ${LOG_FILE}
#sync >> ${LOG_FILE}
#source venv/bin/activate >> ${LOG_FILE}
NEW_VERSION="$(esphome version|cut -d\  -f2)"

#echo OLD=$OLD_VERSION
#echo NEW=$NEW_VERSION

#if [[ "${SANITY,,}" == "true" ]]; then
#	echo "Running sanity checks"
#	if [[ "${OLD_VERSION}" == "${NEW_VERSION}" ]]; then
#		echo "No update found" >> ${LOG_FILE}
#		echo "Ending at $(date)" >> ${LOG_FILE}
#		exit 0
#	fi
#else
#	echo "Not running sanity checks"
#fi

echo "OLD VERSION!: $OLD_VERSION"
echo "NEW VERSION!: $NEW_VERSION"






DEVICES=(
	./fluval-proxy/breeder/fluval-proxy-breeder.yaml
	./fluval-proxy/charlies/fluval-proxy-charlie.yaml
	./bluetooth-proxy/bluetooth-proxy-aquarium.yaml
	./bluetooth-proxy/bluetooth-proxy-dining_room.yaml
	./bluetooth-proxy/bluetooth-proxy-storeroom.yaml
	./bluetooth-proxy/bluetooth-proxy-porch2.yaml
	./bluetooth-proxy/bluetooth-proxy-porch.yaml
	./bluetooth-proxy/bluetooth-proxy-desk.yaml
	./bluetooth-proxy/bluetooth-proxy-plants.yaml
	./kauf-plug/kauf-plug-dehumidifier.yaml
	./kauf-plug/kauf-plug-sump2.yaml
	./kauf-plug/kauf-plug-sump1.yaml
)

for DEVICE in ${DEVICES[@]}; do 
	DEVICE_NAME="$(basename ${DEVICE}|tr - _|sed 's|.yaml||g')"
	SENSOR_ENTITY_ID="sensor.${DEVICE_NAME}_esphome_version"

#	echo "curl -s -H "Authorization: Bearer ${API_TOKEN}" "${HOSTNAME}/api/states/${SENSOR_ENTITY_ID}" | jq -r '.state'"
	DEVICE_FULL_VERSION="$(curl -s -H "Authorization: Bearer ${API_TOKEN}" "${HOSTNAME}/api/states/${SENSOR_ENTITY_ID}" | jq -r '.state')"
	DEVICE_VERSION="$(echo "${DEVICE_FULL_VERSION}" |  cut -d\  -f1)"
	DEVICE_VERSION_DATE="$(echo "${DEVICE_FULL_VERSION}" |  cut -d\  -f2-)"
#	if [[ "${SANITY,,}" == "true" ]]; then
#		if [[ "${DEVICE_VERSION}" == "${NEW_VERSION}" ]]; then
#			echo "Device already at ${NEW_VERSION}" >> ${LOG_FILE}
#			echo "DEVICE_FULL_VERSION=${DEVICE_FULL_VERSION}" >> ${LOG_FILE}
#			break
#		else
			echo "DEVICE:${DEVICE} at $DEVICE_VERSION"
#		fi
#	fi
#	echo "running: esphome clean ${DEVICE}" >> ${LOG_FILE}
#	esphome clean ${DEVICE} >> ${LOG_FILE}
#	echo "running: esphome compile ${DEVICE}" >> ${LOG_FILE}
#	esphome compile ${DEVICE} >> ${LOG_FILE}
#	echo "running: esphome upload ${DEVICE}" >> ${LOG_FILE}
#	esphome upload ${DEVICE} >> ${LOG_FILE}
done
echo "Ending at $(date)" >> ${LOG_FILE}
