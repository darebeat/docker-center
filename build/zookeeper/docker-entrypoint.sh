#!/bin/bash

set -e

# Generate the config only if it doesn't exist
if [[ ! -f "$ZK_CONF_DIR/zoo.cfg" ]]; then
    CONFIG="$ZK_CONF_DIR/zoo.cfg"

    echo "clientPort=$ZK_PORT" >> "$CONFIG"
    echo "dataDir=$ZK_DATA_DIR" >> "$CONFIG"
    echo "dataLogDir=$ZK_DATA_LOG_DIR" >> "$CONFIG"

    echo "tickTime=$ZK_TICK_TIME" >> "$CONFIG"
    echo "initLimit=$ZK_INIT_LIMIT" >> "$CONFIG"
    echo "syncLimit=$ZK_SYNC_LIMIT" >> "$CONFIG"

    echo "maxClientCnxns=$ZK_MAX_CLIENT_CNXNS" >> "$CONFIG"

    for server in $ZK_SERVERS; do
        echo "$server" >> "$CONFIG"
    done
fi

# Write myid only if it doesn't exist
if [[ ! -f "$ZK_DATA_DIR/myid" ]]; then
    echo "${ZK_MY_ID:-1}" > "$ZK_DATA_DIR/myid"
fi

exec "$@"