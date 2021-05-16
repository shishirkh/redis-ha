#!/bin/sh

echo "Give permissions to the redis-sentinel configuration file directory..."
chmod -R 0777 $SENTINEL_CONFIG_FILE_DIR
echo "...permissions assigned."

FILE=/sentinel-conf-file/sentinel.conf
if test -f "$FILE"; then
    echo "$FILE exists. Making files writable..."
    chown redis:redis /sentinel-conf-file/sentinel.conf
    chmod +x /sentinel-conf-file/sentinel.conf
    echo "...files are writable now. Done"
else 
    echo "$FILE does not exist."
    echo "Copying to destination..."
    cp /sentinel-conf-template/sentinel.conf /sentinel-conf-file/sentinel.conf
    echo "...file copied. Making file writable..."
    chown redis:redis /sentinel-conf-file/sentinel.conf
    chmod +x /sentinel-conf-file/sentinel.conf
    echo "...files are writable now. Replacing placeholders with values..."
    sed -i "s/\$SENTINEL_QUORUM/$SENTINEL_QUORUM/g" /sentinel-conf-file/sentinel.conf
    sed -i "s/\$SENTINEL_DOWN_AFTER/$SENTINEL_DOWN_AFTER/g" /sentinel-conf-file/sentinel.conf
    sed -i "s/\$SENTINEL_FAILOVER/$SENTINEL_FAILOVER/g" /sentinel-conf-file/sentinel.conf
    sed -i "s/\$REDIS_MASTER/$REDIS_MASTER/g" /sentinel-conf-file/sentinel.conf
    sed -i "s/\$BIND_ADDR/$BIND_ADDR/g" /sentinel-conf-file/sentinel.conf
    sed -i "s/\$SENTINEL_SVC_IP/$SENTINEL_SVC_IP/g" /sentinel-conf-file/sentinel.conf
    sed -i "s/\$SENTINEL_SVC_PORT/$SENTINEL_SVC_PORT/g" /sentinel-conf-file/sentinel.conf
    sed -i "s/\$SENTINEL_RESOLVE_HOSTNAMES/$SENTINEL_RESOLVE_HOSTNAMES/g" /sentinel-conf-file/sentinel.conf
    sed -i "s/\$SENTINEL_ANNOUNCE_HOSTNAMES/$SENTINEL_ANNOUNCE_HOSTNAMES/g" /sentinel-conf-file/sentinel.conf
    echo "...Done"
fi

echo "Starting redis sentinel process now."
redis-server /sentinel-conf-file/sentinel.conf  --sentinel

