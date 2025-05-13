#!/bin/bash
#
cd $HOME/esphome
pip3 install esphome -U
#source venv/bin/activate

DEVICES=(
	./fluval-proxy/breeder/fluval-proxy-breeder.yaml
#	./fluval-proxy/charlies/fluval-proxy-charlie.yaml
#	./bluetooth-proxy/bluetooth-proxy-aquarium.yaml
#	./bluetooth-proxy/bluetooth-proxy-dining_room.yaml
#	./bluetooth-proxy/bluetooth-proxy-storeroom.yaml
#	./bluetooth-proxy/bluetooth-proxy-porch2.yaml
#	./bluetooth-proxy/bluetooth-proxy-porch.yaml
#	./bluetooth-proxy/bluetooth-proxy-desk.yaml
#	./bluetooth-proxy/bluetooth-proxy-plants.yaml
#	./kauf-plug/kauf-plug-dehumidifier.yaml
	./kauf-plug/kauf-plug-sump2.yaml
	./kauf-plug/kauf-plug-sump1.yaml
#	./switchbot-plug/switchbot-plug-1.yaml
)

for DEVICE in ${DEVICES[@]}; do 

	echo "running: esphome compile ${DEVICE}"
	esphome compile ${DEVICE}
	echo "running: esphome upload ${DEVICE}"
	esphome upload ${DEVICE}
done
