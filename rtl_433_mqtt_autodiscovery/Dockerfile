ARG BUILD_FROM=homeassistant/amd64-base-python:3.9-alpine3.16
FROM ${BUILD_FROM} as builder

ARG rtl433GitRevision=22.11

RUN apk add --no-cache --virtual .buildDeps \
    git

RUN git clone https://github.com/merbanan/rtl_433
WORKDIR rtl_433
RUN git checkout ${rtl433GitRevision}

FROM ${BUILD_FROM}

COPY --from=builder /rtl_433/examples/rtl_433_mqtt_hass.py .
COPY run.sh .

RUN \
    pip install \
        --no-cache-dir \
        --prefer-binary \
        paho-mqtt \
    \
    && chmod a+x /run.sh

CMD [ "/run.sh" ]
