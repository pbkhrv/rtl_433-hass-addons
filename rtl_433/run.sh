#!/usr/bin/env bashio

conf_directory="/config/rtl_433"

if bashio::services.available "mqtt"; then
    host=$(bashio::services "mqtt" "host")
    password=$(bashio::services "mqtt" "password")
    port=$(bashio::services "mqtt" "port")
    username=$(bashio::services "mqtt" "username")
    retain=$(bashio::config "retain")
else
    bashio::log.info "The mqtt addon is not available."
    bashio::log.info "Manually update the output line in the configuration file with mqtt connection settings, and restart the addon."
fi

if [ ! -d $conf_directory ]
then
    mkdir -p $conf_directory
fi

# Check if the legacy configuration file is set and alert that it's deprecated.
conf_file=$(bashio::config "rtl_433_conf_file")

if [[ $conf_file != "" ]]
then
    bashio::log.warning "rtl_433 now supports automatic configuration and multiple radios. The rtl_433_conf_file option is deprecated. See the documentation for migration instructions."
    conf_file="/config/$conf_file"

    echo "Starting rtl_433 -c $conf_file"
    rtl_433 -c "$conf_file"
    exit $?
fi

# Create a reasonable default configuration in /config/rtl_433.
if [ ! "$(ls -A $conf_directory)" ]
then
    cat > $conf_directory/rtl_433.conf.template <<EOD
# This is an empty template for configuring rtl_433. mqtt information will be
# automatically added. Create multiple files ending in '.conf.template' to
# manage multiple rtl_433 radios, being sure to set the 'device' setting.
# https://github.com/merbanan/rtl_433/blob/master/conf/rtl_433.example.conf

output mqtt://\${host}:\${port},user=\${username},pass=\${password},retain=\${retain}

# Uncomment the following line to also enable the default "table" output to the
# addon logs.
# output kv
EOD
fi

# Remove all rendered configuration files.
rm -f $conf_directory/*.conf

rtl_433_pids=()
for template in $conf_directory/*.conf.template
do
    # Remove '.template' from the file name.
    live=$(basename $template .template)

    # By sourcing the template, we can substitute any environment variable in
    # the template. In fact, enterprising users could write _any_ valid bash
    # to create the final configuration file. To simplify template creation,
    # we wrap the needed redirections into a temparary file.
    echo "cat <<EOD > $live" > /tmp/rtl_433_heredoc
    cat $template >> /tmp/rtl_433_heredoc
    echo EOD >> /tmp/rtl_433_heredoc

    source /tmp/rtl_433_heredoc

    echo "Starting rtl_433 with $live..."
    tag=$(basename $live .conf)
    rtl_433 -c "$live" > >(sed "s/^/[$tag] /") 2> >(>&2 sed "s/^/[$tag] /")&
    rtl_433_pids+=($!)
done

wait -n ${rtl_433_pids[*]}
