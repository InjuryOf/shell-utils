#!/bin/sh
set -e

REDISPORT=$2
INSTALL_DIR="/usr/local/bin"
DEMO_DIR="/usr/local/etc/redis-cluster"
EXEC="${INSTALL_DIR}/redis-server"
CLIEXEC="${INSTALL_DIR}/redis-cli"
CONF="${DEMO_DIR}/redis-${REDISPORT}.conf"

case "$1" in
    start)
        echo "Starting Redis server..."
        $EXEC $CONF
    echo "Redis started"
        ;;
    stop)
        echo "Stopping ..."
        $CLIEXEC -p $REDISPORT  shutdown
        echo "Waiting for Redis to shutdown ..."
        sleep 2
        echo "Redis stopped"
        ;;
    *)
        echo "Please use start or stop as first argument"
        ;;
esac
