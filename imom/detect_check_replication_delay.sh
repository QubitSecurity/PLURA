#!/bin/bash

LOG_TAG="plura_batch"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)

MASTER_HOST="192.168.21.220"
SLAVE_HOSTS=("192.168.21.222" "192.168.21.223" "192.168.21.224")  # List of multiple Slave hosts
SSH_USER="root"  # User for SSH connection
MYSQL_USER="root"
MYSQL_PASSWORD="password"

# Set the log file path for normal operation
LOG_FILE="/var/log/plura/mysql_replication_check.log"

# Function to test MySQL connection
function test_mysql_connection {
    local host=$1
    local test_result=$(ssh $SSH_USER@$host "mysql -u $MYSQL_USER -p'$MYSQL_PASSWORD' -e 'SELECT 1;' 2>&1")
    if [[ "$test_result" == *"ERROR"* ]]; then
        logger -t $LOG_TAG -p local0.err "$TIMESTAMP | ERROR: MySQL connection failed on $host - $test_result"
        exit 1
    fi
}

# Function to check Master status
function check_master_status {
    local host=$1
    local master_status=$(ssh $SSH_USER@$host "mysql -u $MYSQL_USER -p'$MYSQL_PASSWORD' -e 'SHOW MASTER STATUS\G'" 2>&1)
    if [ -z "$master_status" ]; then
        logger -t $LOG_TAG -p local0.err "$TIMESTAMP | ERROR: Failed to retrieve master status from MySQL on $host."
        exit 1
    fi
    MASTER_LOG_FILE=$(echo "$master_status" | grep -w 'File:' | awk '{print $2}')
    MASTER_LOG_POS=$(echo "$master_status" | grep -w 'Position:' | awk '{print $2}')
}

# Function to check Slave status
function check_slave_status {
    local host=$1
    local slave_status=$(ssh $SSH_USER@$host "mysql -u $MYSQL_USER -p'$MYSQL_PASSWORD' -e 'SHOW SLAVE STATUS\G'" 2>&1)
    if [ -z "$slave_status" ]; then
        logger -t $LOG_TAG -p local0.err "$TIMESTAMP | ERROR: Failed to retrieve slave status from MySQL on $host."
        exit 1
    fi
    SLAVE_MASTER_LOG_FILE=$(echo "$slave_status" | grep -w 'Master_Log_File:' | awk '{print $2}')
    SLAVE_RELAY_LOG_FILE=$(echo "$slave_status" | grep -w 'Relay_Master_Log_File:' | awk '{print $2}')
    SECS_BEHIND_MASTER=$(echo "$slave_status" | grep -w 'Seconds_Behind_Master:' | awk '{print $2}')
    SLAVE_IO_RUNNING=$(echo "$slave_status" | grep -w 'Slave_IO_Running:' | awk '{print $2}')
    SLAVE_SQL_RUNNING=$(echo "$slave_status" | grep -w 'Slave_SQL_Running:' | awk '{print $2}')
}

# Test MySQL connection to Master
test_mysql_connection $MASTER_HOST

# Check Master status
check_master_status $MASTER_HOST

# Loop through each Slave and check status
for SLAVE_HOST in "${SLAVE_HOSTS[@]}"; do
    # Test MySQL connection to Slave
    test_mysql_connection $SLAVE_HOST

    # Check Slave status
    check_slave_status $SLAVE_HOST

    # Handle NULL synchronization delay time
    if [ -z "$SECS_BEHIND_MASTER" ]; then
        SECS_BEHIND_MASTER="NULL"
    fi

    # Handle cases where replication is not running
    if [ "$SLAVE_IO_RUNNING" != "Yes" ] || [ "$SLAVE_SQL_RUNNING" != "Yes" ]; then
        logger -t $LOG_TAG -p local0.err "$TIMESTAMP | ERROR: Slave IO or SQL process is not running on $SLAVE_HOST! Check replication status."
        exit 2
    fi

    # Log the normal status to the specified log file
    echo "$TIMESTAMP | Status=OK, Slave=$SLAVE_HOST, Master_Log_File=$MASTER_LOG_FILE, Master_Log_Position=$MASTER_LOG_POS, Slave_Master_Log_File=$SLAVE_MASTER_LOG_FILE, Relay_Log_File=$SLAVE_RELAY_LOG_FILE, Seconds_Behind_Master=$SECS_BEHIND_MASTER, Slave_IO_Running=$SLAVE_IO_RUNNING, Slave_SQL_Running=$SLAVE_SQL_RUNNING" >> $LOG_FILE
done

exit 0 # Exit with a success code
