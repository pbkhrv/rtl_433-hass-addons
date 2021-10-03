ARG BUILD_FROM=homeassistant/amd64-base-python:3.9-alpine3.13
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

# Copy files from root folder
COPY run.sh rtl_433_mqtt_hass.py requirements.txt /

# Setup base
ARG BUILD_ARCH=amd64
# hadolint ignore=DL3003
RUN \
    apk add --no-cache \
        py3-pip \
        python3 \
    \
    && pip install \
        --no-cache-dir \
        --prefer-binary \
        --find-links "https://wheels.home-assistant.io/alpine-3.14/${BUILD_ARCH}/" \
        -r /requirements.txt \
    \
    && chmod a+x /run.sh

CMD [ "/run.sh" ]
