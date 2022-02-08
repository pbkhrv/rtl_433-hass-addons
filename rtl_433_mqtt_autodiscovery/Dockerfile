ARG BUILD_FROM=homeassistant/amd64-base-python:3.9-alpine3.13
FROM ${BUILD_FROM} as builder

ARG rtl433GitRevision=2b49b81aafee4aef6015385ee44dc7e0d9f0073d

# Copy files from root folder
COPY 1665.diff \
     /

RUN apk add patch
RUN wget https://raw.githubusercontent.com/merbanan/rtl_433/${rtl433GitRevision}/examples/rtl_433_mqtt_hass.py -O rtl_433_mqtt_hass.py
# https://github.com/merbanan/rtl_433/pull/1665.diff
RUN patch -u rtl_433_mqtt_hass.py 1665.diff

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
