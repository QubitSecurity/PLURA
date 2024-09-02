# iMom
Backing 시스템을 모니터링합니다.

### 1. MySQL
### 2. Redis
### 3. Solr
### 4. Kafka

<hr/>

## 1. MySQL

이상 탐지 시 스크립트가 출력하는 로그는 `Status=ERROR`로 설정되며, 시스템 로그(`logger`)와 `LOG_FILE`에 기록됩니다. 예를 들어, `Seconds_Behind_Master`가 30초 이상인 경우, 또는 `Slave_IO_Running`이나 `Slave_SQL_Running`이 `Yes`가 아닌 경우의 로그 출력을 보여드리겠습니다.

### 가정된 이상 상황 예시

- **`Seconds_Behind_Master`가 270초**: 슬레이브가 마스터로부터 270초(4분 30초) 지연된 경우.
- **`Slave_SQL_Running`이 `No`**: 슬레이브의 SQL 스레드가 실행되지 않고 중지된 경우.

### 이상 탐지 로그 출력 예시

#### 1. **`Seconds_Behind_Master`가 270초인 경우**

```bash
2024-09-02 08:35:21 | Status=OK, Master=10.100.21.230, Master_Log_File=mysql-bin.016068, Master_Log_Position=620123456
2024-09-02 08:35:21 | Status=OK, Slave=10.100.21.232, Master_Log_File=mysql-bin.016068, Master_Log_Position=620123456, Slave_Master_Log_File=mysql-bin.016068, Slave_Read_Master_Log_Pos=620500123, Relay_Master_Log_File=mysql-bin.016068, Exec_Master_Log_Pos=620450000, Seconds_Behind_Master=0, Slave_IO_Running=Yes, Slave_SQL_Running=Yes
2024-09-02 08:35:21 | Status=OK, Slave=10.100.21.233, Master_Log_File=mysql-bin.016068, Master_Log_Position=620123456, Slave_Master_Log_File=mysql-bin.016068, Slave_Read_Master_Log_Pos=620678900, Relay_Master_Log_File=mysql-bin.016068, Exec_Master_Log_Pos=620678900, Seconds_Behind_Master=0, Slave_IO_Running=Yes, Slave_SQL_Running=Yes
2024-09-02 08:35:21 | Status=ERROR, Slave=10.100.21.234, Master_Log_File=mysql-bin.016068, Master_Log_Position=620123456, Slave_Master_Log_File=mysql-bin.016068, Slave_Read_Master_Log_Pos=621000000, Relay_Master_Log_File=mysql-bin.016068, Exec_Master_Log_Pos=620980000, Seconds_Behind_Master=270, Slave_IO_Running=Yes, Slave_SQL_Running=Yes
```

**시스템 로그 (logger) 출력**:

```bash
Sep 02 08:35:21 mysql_check: Status=ERROR, Slave=10.100.21.234, Master_Log_File=mysql-bin.016068, Master_Log_Position=620123456, Slave_Master_Log_File=mysql-bin.016068, Slave_Read_Master_Log_Pos=621000000, Relay_Master_Log_File=mysql-bin.016068, Exec_Master_Log_Pos=620980000, Seconds_Behind_Master=270, Slave_IO_Running=Yes, Slave_SQL_Running=Yes
```

#### 2. **`Slave_SQL_Running`이 `No`인 경우**

```bash
2024-09-02 08:40:15 | Status=OK, Master=10.100.21.230, Master_Log_File=mysql-bin.016068, Master_Log_Position=621234567
2024-09-02 08:40:15 | Status=OK, Slave=10.100.21.232, Master_Log_File=mysql-bin.016068, Master_Log_Position=621234567, Slave_Master_Log_File=mysql-bin.016068, Slave_Read_Master_Log_Pos=621500000, Relay_Master_Log_File=mysql-bin.016068, Exec_Master_Log_Pos=621490000, Seconds_Behind_Master=0, Slave_IO_Running=Yes, Slave_SQL_Running=Yes
2024-09-02 08:40:15 | Status=OK, Slave=10.100.21.233, Master_Log_File=mysql-bin.016068, Master_Log_Position=621234567, Slave_Master_Log_File=mysql-bin.016068, Slave_Read_Master_Log_Pos=621789012, Relay_Master_Log_File=mysql-bin.016068, Exec_Master_Log_Pos=621780000, Seconds_Behind_Master=0, Slave_IO_Running=Yes, Slave_SQL_Running=Yes
2024-09-02 08:40:15 | Status=ERROR, Slave=10.100.21.234, Master_Log_File=mysql-bin.016068, Master_Log_Position=621234567, Slave_Master_Log_File=mysql-bin.016068, Slave_Read_Master_Log_Pos=622000000, Relay_Master_Log_File=mysql-bin.016068, Exec_Master_Log_Pos=621980000, Seconds_Behind_Master=0, Slave_IO_Running=Yes, Slave_SQL_Running=No
```

**시스템 로그 (logger) 출력**:

```bash
Sep 02 08:40:15 mysql_check: Status=ERROR, Slave=10.100.21.234, Master_Log_File=mysql-bin.016068, Master_Log_Position=621234567, Slave_Master_Log_File=mysql-bin.016068, Slave_Read_Master_Log_Pos=622000000, Relay_Master_Log_File=mysql-bin.016068, Exec_Master_Log_Pos=621980000, Seconds_Behind_Master=0, Slave_IO_Running=Yes, Slave_SQL_Running=No
```

### 요약

- **`LOG_FILE` 기록**: 모든 상태 정보가 기록되며, 정상 상태는 `Status=OK`로, 이상 상태는 `Status=ERROR`로 기록됩니다.
- **`logger` 시스템 로그 기록**: `Status=ERROR`인 경우에만 시스템 로그에 기록됩니다.

이 예시를 통해 `Seconds_Behind_Master`가 30초 이상이거나, 복제 관련 프로세스가 정상적으로 실행되지 않을 때 스크립트가 적절하게 오류를 감지하고 로그에 기록함을 확인할 수 있습니다.

<hr/>

## 2. Redis

수정된 Redis 점검 스크립트에서의 이상 탐지 조건과 그에 따른 예상 출력은 다음과 같습니다.

### 이상 탐지 조건

1. **Redis 노드의 역할 불일치**:
   - **마스터 노드**: 스크립트에서 `expected_role`이 `master`로 설정된 Redis 노드가 실제로 `master` 역할을 수행하지 않는 경우.
   - **슬레이브 노드**: 스크립트에서 `expected_role`이 `slave`로 설정된 Redis 노드가 실제로 `slave` 역할을 수행하지 않는 경우.

2. **기타 Redis 노드 상태 문제**:
   - 스크립트에서 Redis 노드의 상태를 확인할 때, `redis-cli` 명령어를 통해 올바른 정보를 가져오지 못하는 경우도 이상으로 간주될 수 있습니다.

### 예상 출력

#### 1. **마스터 노드가 예상 역할을 수행하지 않는 경우**

- **상황**: `192.168.21.141` 노드가 `master`로 예상되지만, 실제로 `slave` 역할을 수행하고 있는 경우.

**`LOG_FILE` 출력**:

```bash
2024-09-02 08:45:32 | CRITICAL: Node 192.168.21.141:6381 is expected to be master but found slave
```

**시스템 로그 (`logger`) 출력**:

```bash
Sep 02 08:45:32 redis_check: CRITICAL: Node 192.168.21.141:6381 is expected to be master but found slave
```

#### 2. **슬레이브 노드가 예상 역할을 수행하지 않는 경우**

- **상황**: `192.168.21.152` 노드가 `slave`로 예상되지만, 실제로 `master` 역할을 수행하고 있는 경우.

**`LOG_FILE` 출력**:

```bash
2024-09-02 08:46:10 | CRITICAL: Node 192.168.21.152:6381 is expected to be slave but found master
```

**시스템 로그 (`logger`) 출력**:

```bash
Sep 02 08:46:10 redis_check: CRITICAL: Node 192.168.21.152:6381 is expected to be slave but found master
```

### 이상 탐지 흐름

1. **마스터 노드 점검**:
   - 스크립트는 배열에 정의된 모든 마스터 노드를 순차적으로 점검합니다.
   - 각 노드가 `master` 역할을 수행하는지 확인합니다. 그렇지 않은 경우, `Status=ERROR`로 간주하고 해당 로그를 기록합니다.

2. **슬레이브 노드 점검**:
   - 스크립트는 배열에 정의된 모든 슬레이브 노드를 순차적으로 점검합니다.
   - 각 노드가 `slave` 역할을 수행하는지 확인합니다. 그렇지 않은 경우, `Status=ERROR`로 간주하고 해당 로그를 기록합니다.

3. **정상 상태**:
   - 모든 점검이 성공적으로 완료되면, `LOG_FILE`에 정상 상태 로그가 기록되며, `Status=OK`로 간주됩니다.

### 요약

이상 탐지 조건이 충족되면, 해당 Redis 노드의 역할 불일치에 대해 `CRITICAL` 로그 메시지가 기록됩니다. 이 메시지는 `LOG_FILE`에 타임스탬프와 함께 기록되며, 시스템 로그에는 타임스탬프 없이 기록됩니다.

이 스크립트를 통해 Redis 클러스터의 노드 역할을 정확하게 모니터링하고, 예상과 다른 역할을 수행하는 노드에 대해 즉시 경고를 받을 수 있습니다.

<hr/>

# 3. Solr

아래는 Solr 점검 스크립트의 이상 탐지 시 로그 출력 예시와 시스템 로그(`logger`) 및 `LOG_FILE`에 기록되는 내용을 설명한 것입니다. MySQL 점검 스크립트의 양식을 따릅니다.

### 가정된 이상 상황 예시

1. **`recovering` 상태의 코어가 있는 경우**: Solr의 특정 코어가 `recovering` 상태에 있는 경우.
2. **`down` 상태의 코어가 있는 경우**: Solr의 특정 코어가 `down` 상태에 있는 경우.

### 이상 탐지 로그 출력 예시

#### 1. **`recovering` 상태의 코어가 있는 경우**

- **상황**: Solr 인스턴스에서 2개의 코어가 `recovering` 상태에 있음.

**`LOG_FILE` 출력**:

```bash
2024-09-02 09:35:21 | CRITICAL: 2 core(s) are in recovering state on Solr instance 10.100.41.69:8983
```

**시스템 로그 (`logger`) 출력**:

```bash
Sep 02 09:35:21 solr_check: CRITICAL: 2 core(s) are in recovering state on Solr instance 10.100.41.69:8983
```

#### 2. **`down` 상태의 코어가 있는 경우**

- **상황**: Solr 인스턴스에서 1개의 코어가 `down` 상태에 있음.

**`LOG_FILE` 출력**:

```bash
2024-09-02 09:40:15 | CRITICAL: 1 core(s) are in down state on Solr instance 10.100.41.69:8983
```

**시스템 로그 (`logger`) 출력**:

```bash
Sep 02 09:40:15 solr_check: CRITICAL: 1 core(s) are in down state on Solr instance 10.100.41.69:8983
```

### 요약

- **`LOG_FILE` 기록**: 모든 상태 정보가 기록되며, 정상 상태는 `Status=OK`로, 이상 상태는 `Status=ERROR`로 기록됩니다.
- **시스템 로그 (`logger`) 기록**: `Status=ERROR`인 경우에만 시스템 로그에 기록됩니다.

이 예시를 통해 Solr의 코어가 `recovering` 또는 `down` 상태에 있을 때, 스크립트가 적절하게 오류를 감지하고 로그에 기록함을 확인할 수 있습니다.

<hr/>

## 4. Kafka

아래는 Kafka 점검 스크립트에 대한 설명입니다. MySQL 점검 스크립트의 설명 방식과 동일하게 적용되었습니다.

### 이상 탐지 시 스크립트가 출력하는 로그

이 스크립트는 Kafka 클러스터의 상태를 점검하며, 이상 탐지 시 `Status=ERROR`로 설정된 로그를 시스템 로그(`logger`)와 `LOG_FILE`에 기록합니다. 예를 들어, Kafka 클러스터의 오프라인 파티션이 있는 경우, 리더가 없는 파티션이 있는 경우, 또는 소비자의 Lag가 임계값을 초과한 경우의 로그 출력을 보여드리겠습니다.

### 가정된 이상 상황 예시

1. **오프라인 파티션이 있는 경우**: Kafka 클러스터에서 오프라인 파티션이 발생한 경우.
2. **리더가 없는 파티션이 있는 경우**: Kafka 클러스터에서 리더가 없는 파티션이 발생한 경우.
3. **Lag가 임계값을 초과한 경우**: Kafka 클러스터에서 소비자의 Lag가 임계값(예: 10000)을 초과한 경우.

### 이상 탐지 로그 출력 예시

#### 1. **오프라인 파티션이 있는 경우**

- **상황**: Kafka 클러스터에서 3개의 오프라인 파티션이 발생한 경우.

**`LOG_FILE` 출력**:

```bash
2024-09-02 08:35:21 | CRITICAL: Topic=web, Offline_Partitions=3 across brokers, Consumer_Group=analysis-weblog
```

**시스템 로그 (`logger`) 출력**:

```bash
Sep 02 08:35:21 kafka_check: CRITICAL: Topic=web, Offline_Partitions=3 across brokers, Consumer_Group=analysis-weblog
```

#### 2. **리더가 없는 파티션이 있는 경우**

- **상황**: Kafka 클러스터에서 2개의 리더가 없는 파티션이 발생한 경우.

**`LOG_FILE` 출력**:

```bash
2024-09-02 08:40:15 | CRITICAL: Topic=web, Partitions_without_Leader=2 across brokers, Consumer_Group=analysis-weblog
```

**시스템 로그 (`logger`) 출력**:

```bash
Sep 02 08:40:15 kafka_check: CRITICAL: Topic=web, Partitions_without_Leader=2 across brokers, Consumer_Group=analysis-weblog
```

#### 3. **Lag가 임계값을 초과한 경우**

- **상황**: Kafka 클러스터에서 소비자의 Lag가 임계값(예: 10000)을 초과한 경우.

**`LOG_FILE` 출력**:

```bash
2024-09-02 08:45:30 | CRITICAL: Topic=web, Lag exceeded threshold on 1 brokers, Threshold=10000, Consumer_Group=analysis-weblog
```

**시스템 로그 (`logger`) 출력**:

```bash
Sep 02 08:45:30 kafka_check: CRITICAL: Topic=web, Lag exceeded threshold on 1 brokers, Threshold=10000, Consumer_Group=analysis-weblog
```

### 요약

- **`LOG_FILE` 기록**: 모든 상태 정보가 기록되며, 정상 상태는 `Status=OK`로, 이상 상태는 `Status=ERROR`로 기록됩니다.
- **시스템 로그 (`logger`) 기록**: `Status=ERROR`인 경우에만 시스템 로그에 기록됩니다.

이 예시를 통해 Kafka 클러스터에서 오프라인 파티션이 있거나, 리더가 없는 파티션이 발생하거나, 소비자의 Lag가 임계값을 초과할 때 스크립트가 적절하게 오류를 감지하고 로그에 기록함을 확인할 수 있습니다.

<hr/>
