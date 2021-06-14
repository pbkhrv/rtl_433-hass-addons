ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

MAINTAINER pbkhrv@pm.me

# Install latest pip
RUN python3 -m ensurepip && \
    pip3 install --no-cache --upgrade pip

# Install rtl_433 mqtt bridge prereq
RUN pip3 install --no-cache paho-mqtt

# Clone rtl_433 repo and copy the latest tested version of the mqtt bridge script
# (latest as of 12/25/2020)
RUN curl -LO https://raw.githubusercontent.com/bartrumb/rtl_433-hass-addons/main/rtl_433_mqtt_autodiscovery/rtl_433_mqtt_hass.py && \
  chmod +x /rtl_433_mqtt_hass.py

# Run script
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
