ARG BUILD_FROM=homeassistant/amd64-base-python:3.9-alpine3.13
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

# Copy files from root folder
COPY run.sh rtl_433_mqtt_hass.py requirements.txt /

# Setup base
ARG BUILD_ARCH=amd64
# hadolint ignore=DL3003
RUN \
    apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r2 \
        libffi-dev=3.3-r2 \
        openssl-dev=1.1.1l-r0 \
        py3-wheel=0.36.2-r2 \
        python3-dev=3.9.5-r1 \
    \
    && apk add --no-cache \
        py3-pip=20.3.4-r1 \
        py3-bcrypt=3.2.0-r3 \
        python3=3.9.5-r1 \
    \
    && pip install \
        --no-cache-dir \
        --prefer-binary \
        --find-links "https://wheels.home-assistant.io/alpine-3.14/${BUILD_ARCH}/" \
        -r /requirements.txt \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && apk del --no-cache --purge .build-dependencies \
    \
    && chmod a+x /run.sh

CMD [ "/run.sh" ]
