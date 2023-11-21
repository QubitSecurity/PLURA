# 네트워크 탐지로그

## 네트워크 메시지 템플릿 구조
```
CEF:0|QubitSecurity|Plura|5|([[${eventName}]])[[${serviceName}]]|[[${filterName}]]|[[${filterRiskLevel}]]|end=[[${registerDate}]] cs1=[[${filterName}]] cs2=[[${filterCategoryName}]] src=[[${detectIp}]] dvc=[[${serverIp}]] dst=[[${serverName}]][# th:if="${isUseLogOrigin == '1'}"] cs6=[[${logOrigin}]][/]
```

## 네트워크 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (네트워크탐지)|
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |filterRiskLevel             | 필터 위험도|
|end|registerDate                | 이벤트 발생시간|
|cs1|filterName                  | 필터 이름|
|cs2|filterCategoryName          | 필터 카테고리 이름     |
|src|detectIp                    | 공격자 아이피|
|dvc|serverIp                    | 대상 시스템 아이피 (에이전트)|
|dst|serverName                  | 대상 시스템 이름 (에이전트)|
|cs6|logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 12:50:30 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(탐지)네트워크|JunOS - harry|2|end=Jun 16 2022 12:24:56 cs1=JunOS - harry cs2=etc. src=- dvc=172.16.12.41 dst=172.16.12.41 cs6= node\=CentOS7 type\=GRP_MGMT msg\=audit(1655351320.957:411): pid\=2878 uid\=0 auid\=0 ses\=25 subj\=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 msg\=&#39;op\=delete-shadow-group grp\=\&quot;harry\&quot; acct\=\&quot;harry\&quot; exe\=\&quot;/usr/sbin/userdel\&quot; hostname\=CentOS7 addr\=? terminal\=pts/0 res\=success&#39;
```
