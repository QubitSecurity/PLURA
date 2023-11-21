# 시스템 탐지로그

## 시스템 메시지 템플릿 구조
```
CEF:0|QubitSecurity|Plura|5|([[${eventName}]])[[${serviceName}]]|[[${filterName}]]|[[${filterRiskLevel}]]|end=[[${registerDate}]] cs1=[[${filterName}]] cs2=[[${filterCategoryName}]] src=[[${detectIp}]] dvc=[[${serverIp}]] dst=[[${serverName}]][# th:if="${isUseLogOrigin == '1'}"] cs6=[[${logOrigin}]][/]
```

## 시스템 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (시스템탐지)|
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
Jun 16 12:44:15 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(탐지)시스템|로그인 성공-Harry-Syslog|4|end=Jun 16 2022 12:18:41 cs1=로그인 성공-Harry-Syslog cs2=로그온/로그오프 src=172.16.20.192 dvc=172.16.12.40 dst=Harry-LP-L cs6=Accepted password for root from 172.16.20.192 port 56019 ssh2

```
