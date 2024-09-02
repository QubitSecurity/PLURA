#!/bin/bash

LOG_TAG="kafka_check"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Define the Kafka brokers' IP addresses and ports in an array
KAFKA_BROKERS=(
    "192.168.22.101:9092"
    "192.168.22.102:9092"
    "192.168.22.103:9092"
    "192.168.22.104:9092"
    "192.168.22.105:9092"
    "192.168.22.106:9092"
    "192.168.22.107:9092"
    "192.168.22.108:9092"
)

# Define the base path for Kafka scripts
KAFKA_SCRIPT_PATH="/usr/kafka/bin"

# Set the log file path for normal operation
LOG_FILE="/var/log/plura/kafka_check_status.log"

# Define the lag threshold (in number of messages)
LAG_THRESHOLD=10000  # Set your threshold value here

# Example: Fetch the current lag for a specific topic and consumer group
TOPIC="web"
CONSUMER_GROUP="analysis-weblog"

# Initialize counters for errors
offline_partitions_total=0
partitions_without_leader_total=0
lag_exceeded_total=0

# Initialize status
status_ok=true

# Loop through each broker and perform checks
for BROKER in "${KAFKA_BROKERS[@]}"; do
    # Fetch the current lag using kafka-consumer-groups.sh command
    current_lag=$($KAFKA_SCRIPT_PATH/kafka-consumer-groups.sh --bootstrap-server $BROKER --describe --group $CONSUMER_GROUP | grep $TOPIC | awk '{print $6}')

    # Ensure current_lag is an integer; set to 0 if empty or invalid
    current_lag=${current_lag:-0}
    if ! [[ "$current_lag" =~ ^[0-9]+$ ]]; then
        current_lag=0
    fi

    # Run Kafka-topics command to check the cluster status using --bootstrap-server
    offline_partitions=$($KAFKA_SCRIPT_PATH/kafka-topics.sh --describe --bootstrap-server $BROKER | grep "Offline" | wc -l)
    partitions_without_leader=$($KAFKA_SCRIPT_PATH/kafka-topics.sh --describe --bootstrap-server $BROKER | grep "Leader: -1" | wc -l)

    # Aggregate the counts
    offline_partitions_total=$((offline_partitions_total + offline_partitions))
    partitions_without_leader_total=$((partitions_without_leader_total + partitions_without_leader))
    
    if [ "$current_lag" -gt "$LAG_THRESHOLD" ]; then
        lag_exceeded_total=$((lag_exceeded_total + 1))
    fi

    # Check aggregated results and log them
    if [ "$offline_partitions_total" -gt 0 ]; then
        message="CRITICAL: Topic=$TOPIC, Offline_Partitions=$offline_partitions_total across brokers, Consumer_Group=$CONSUMER_GROUP"
        logger -t $LOG_TAG -p local0.err "$message"
        echo "$TIMESTAMP | $message" >> $LOG_FILE
        status_ok=false
    fi

    if [ "$partitions_without_leader_total" -gt 0 ]; then
        message="CRITICAL: Topic=$TOPIC, Partitions_without_Leader=$partitions_without_leader_total across brokers, Consumer_Group=$CONSUMER_GROUP"
        logger -t $LOG_TAG -p local0.err "$message"
        echo "$TIMESTAMP | $message" >> $LOG_FILE
        status_ok=false
    fi

    if [ "$lag_exceeded_total" -gt 0 ]; then
        message="CRITICAL: Topic=$TOPIC, Lag exceeded threshold on $lag_exceeded_total brokers, Threshold=$LAG_THRESHOLD, Consumer_Group=$CONSUMER_GROUP"
        logger -t $LOG_TAG -p local0.err "$message"
        echo "$TIMESTAMP | $message" >> $LOG_FILE
        status_ok=false
    fi
done

# If all checks pass, log an OK status to the specified log file
if $status_ok; then
    message="Status=OK, Topic=$TOPIC, Lag=$current_lag, Threshold=$LAG_THRESHOLD, Offline_Partitions=$offline_partitions_total, Partitions_without_Leader=$partitions_without_leader_total, Kafka_Brokers=${#KAFKA_BROKERS[@]}"
    echo "$TIMESTAMP | $message" >> $LOG_FILE
    exit 0 # OK
else
    exit 2 # CRITICAL
fi
