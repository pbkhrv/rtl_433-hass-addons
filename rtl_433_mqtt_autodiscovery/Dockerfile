ARG BUILD_FROM=homeassistant/amd64-base-python:3.9-alpine3.16
FROM ${BUILD_FROM} as builder

ARG rtl433GitRevision=22.11

RUN wget https://raw.githubusercontent.com/merbanan/rtl_433/${rtl433GitRevision}/examples/rtl_433_mqtt_hass.py -O rtl_433_mqtt_hass.py

COPY version.json .

RUN wget https://raw.githubusercontent.com/merbanan/rtl_433/master/examples/rtl_433_mqtt_hass.py -O rtl_433_mqtt_hass_master.py

FROM ${BUILD_FROM}

COPY --from=builder rtl_433_mqtt_hass.py .
COPY --from=builder rtl_433_mqtt_hass_master.py .
COPY run.sh .

RUN \
    pip install \
        --no-cache-dir \
        --prefer-binary \
        paho-mqtt \
    \
    && chmod a+x /run.sh

CMD [ "/run.sh" ]
