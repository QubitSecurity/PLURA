#!/bin/bash

LOG_TAG="redis_check"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Define the Redis port as a variable
REDIS_PORT=6381

# Define the Redis nodes' IP addresses in arrays (ports are managed separately)
REDIS_MASTERS=(
    "192.168.21.140"
    "192.168.21.141"
    "192.168.21.142"
    "192.168.21.143"
    "192.168.21.144"
)

REDIS_SLAVES=(
    "192.168.21.150"
    "192.168.21.151"
    "192.168.21.152"
    "192.168.21.153"
    "192.168.21.154"
)

# Set the log file path for normal operation
LOG_FILE="/var/log/plura/check_status_redis.log"

# Function to check the status of a Redis node
check_redis_node() {
    local node=$1
    local expected_role=$2
    
    # Check the node status using the variable port
    redis_info=$(redis-cli -h $node -p $REDIS_PORT CLUSTER NODES | grep "$node:$REDIS_PORT")
    role_type=$(echo "$redis_info" | awk '{print $3}' | cut -d',' -f1)
    
    # Handle the "myself" keyword by appending the actual role (master or slave)
    if [[ "$role_type" == "myself" ]]; then
        role_type=$(echo "$redis_info" | awk '{print $3}' | cut -d',' -f2)
    fi
    
    # Prepare the message
    local message="CRITICAL: Node $node:$REDIS_PORT is expected to be $expected_role but found $role_type"

    if [ "$expected_role" == "master" ]; then
        if [ "$role_type" != "master" ]; then
            logger -t $LOG_TAG -p local0.err "$message"
            echo "$TIMESTAMP | $message" >> $LOG_FILE
            return 1
        fi
    elif [ "$expected_role" == "slave" ]; then
        if [ "$role_type" != "slave" ]; then
            logger -t $LOG_TAG -p local0.err "$message"
            echo "$TIMESTAMP | $message" >> $LOG_FILE
            return 1
        fi
    fi
    
    return 0
}

# Initialize status
status_ok=true

# Check all master nodes
for node in "${REDIS_MASTERS[@]}"; do
    check_redis_node $node "master"
    if [ $? -ne 0 ]; then
        status_ok=false
    fi
done

# Check all slave nodes
for node in "${REDIS_SLAVES[@]}"; do
    check_redis_node $node "slave"
    if [ $? -ne 0 ]; then
        status_ok=false
    fi
done

# If all checks pass, log an OK status to the specified log file
if $status_ok; then
    echo "$TIMESTAMP | Status=OK, Redis Cluster is running properly with ${#REDIS_MASTERS[@]} masters and ${#REDIS_SLAVES[@]} slaves on port $REDIS_PORT" >> $LOG_FILE
    exit 0 # OK
else
    exit 2 # CRITICAL
fi
