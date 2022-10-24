ARG BUILD_FROM=homeassistant/amd64-base-python:3.9-alpine3.16
FROM ${BUILD_FROM} as builder

ARG rtl433GitRevision=e066b669f7574c37f943f251ec8023b00cff1df6

# Copy files from root folder
COPY 2102.diff \
     /

RUN apk add patch
RUN wget https://raw.githubusercontent.com/merbanan/rtl_433/${rtl433GitRevision}/examples/rtl_433_mqtt_hass.py -O rtl_433_mqtt_hass.py

# https://github.com/merbanan/rtl_433/pull/2102
RUN patch -u rtl_433_mqtt_hass.py 2102.diff

FROM ${BUILD_FROM}

COPY --from=builder rtl_433_mqtt_hass.py .
COPY run.sh .

RUN \
    pip install \
        --no-cache-dir \
        --prefer-binary \
        paho-mqtt \
    \
    && chmod a+x /run.sh

CMD [ "/run.sh" ]
