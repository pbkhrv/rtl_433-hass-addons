ARG BUILD_FROM=homeassistant/amd64-base-python:3.9-alpine3.13
FROM ${BUILD_FROM}

ARG rtl433GitRevision=21.12

# Copy files from root folder
COPY run.sh \
     0001-Remove-invalid-device_classes-moisture-safety-and-depth.patch \
     /

RUN apk add patch
RUN wget https://raw.githubusercontent.com/merbanan/rtl_433/${rtl433GitRevision}/examples/rtl_433_mqtt_hass.py -O rtl_433_mqtt_hass.py
RUN patch -u rtl_433_mqtt_hass.py 0001-Remove-invalid-device_classes-moisture-safety-and-depth.patch


RUN \
    pip install \
        --no-cache-dir \
        --prefer-binary \
        paho-mqtt \
    \
    && chmod a+x /run.sh

CMD [ "/run.sh" ]
