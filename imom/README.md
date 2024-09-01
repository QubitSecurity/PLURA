## 1. iMom

### 1.0 MySQL

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
