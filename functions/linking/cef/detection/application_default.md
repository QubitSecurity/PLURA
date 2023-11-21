# 응용프로그램 탐지로그

## 응용프로그램 메시지 템플릿 구조
```
CEF:0|QubitSecurity|Plura|5|([[${eventName}]])[[${serviceName}]]|[[${filterName}]]|[[${filterRiskLevel}]]|end=[[${registerDate}]] cs1=[[${filterName}]] cs2=[[${filterCategoryName}]] cs3=[[${logConfigPath}]] src=[[${detectIp}]] dvc=[[${serverIp}]] dst=[[${serverName}]][# th:if="${isUseLogOrigin == '1'}"] cs6=[[${logOrigin}]][/]
```

## 응용프로그램 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (응용프로그램)|
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |filterRiskLevel             | 필터 위험도|
|end|registerDate                | 이벤트 발생시간|
|cs1|filterName                  | 필터 이름|
|cs2|filterCategoryName          | 필터 카테고리 이름     |
|cs3|logConfigPath               | 로그 발생 파일 경    |     
|src|detectIp                    | 공격자 아이피|
|dvc|serverIp                    | 대상 시스템 아이피 (에이전트)|
|dst|serverName                  | 대상 시스템 이름 (에이전트)|
|cs6|logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 12:45:00 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(탐지)응용프로그램 원본|QA-ceelog|4|end=Jun 16 2022 12:28:59 cs1=QA-ceelog cs2=원본 cs3=/var/log/plura/ceelog-127.0.0.1.log src=- dvc=172.16.12.40 dst=Harry-LP-L cs6=\&quot;node\=CentOS7 type\=CRED_DISP msg\=audit(1655350993.092:1061): pid\=7816 uid\=0 auid\=0 ses\=25 subj\=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 msg\=&#39;op\=PAM:setcred grantors\=pam_unix acct\=\&quot;root\&quot; exe\=\&quot;/usr/sbin/sshd\&quot; hostname\=172.16.20.192 addr\=172.16.20.192 terminal\=ssh res\=success&#39;\&quot;}}
```
