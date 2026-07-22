#!/bin/bash
#
# ==========================================================
# docker_event_monitor.sh
#
# Engineering for Failure
# Docker Swarm Event Monitor
#
# Listens for Docker events and records all container
# failures to a log file monitored by CloudWatch.
#
# Compatible with Amazon Linux 2023
# ==========================================================

LOGFILE="/var/log/docker-events.log"

# Ensure log file exists
touch "$LOGFILE"
chmod 644 "$LOGFILE"

echo "$(date '+%Y-%m-%d %H:%M:%S') Docker Event Monitor Started" >> "$LOGFILE"

docker events \
    --filter type=container \
    --filter event=die \
    --filter event=stop \
| while read line
do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    CONTAINER=$(echo "$line" | awk '{print $4}')

    echo "$TIMESTAMP ContainerFailure container=$CONTAINER event=stopped" >> "$LOGFILE"
done