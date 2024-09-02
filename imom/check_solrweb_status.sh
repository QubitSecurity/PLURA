#!/bin/bash

LOG_TAG="solr_check"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Manually define the Solr server's IP address and port
SOLR_HOST="192.168.41.69"  # Enter the Solr server's IP address here
SOLR_PORT="8983"           # Enter the Solr server's port number here

# Set the log file path for normal operation
LOG_FILE="/var/log/plura/check_status_solr.log"

# Construct the Solr CLUSTERSTATUS API URL (checking overall status without specifying core name)
SOLR_URL="http://$SOLR_HOST:$SOLR_PORT/solr/admin/collections?action=CLUSTERSTATUS"

# Retrieve the status information from Solr using curl
response=$(curl -s $SOLR_URL)

# Find cores in the 'recovering' state
recovering_count=$(echo $response | grep -o '"state":"recovering"' | wc -l)

# Find cores in the 'down' state
down_count=$(echo $response | grep -o '"state":"down"' | wc -l)

# Handle and log based on the status
if [ "$recovering_count" -gt 0 ]; then
    logger -t $LOG_TAG -p local0.err "$TIMESTAMP | CRITICAL: $recovering_count core(s) are in recovering state on Solr instance $SOLR_HOST:$SOLR_PORT"
    exit 2 # CRITICAL
elif [ "$down_count" -gt 0 ]; then
    logger -t $LOG_TAG -p local0.err "$TIMESTAMP | CRITICAL: $down_count core(s) are in down state on Solr instance $SOLR_HOST:$SOLR_PORT"
    exit 2 # CRITICAL
else
    echo "$TIMESTAMP | Status=OK, Solr_Host=$SOLR_HOST, Solr_Port=$SOLR_PORT" >> $LOG_FILE
    exit 0 # Log OK status and exit if all cores are normal
fi
