# 데이터유출 방어로그

## 데이터유출 방어 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterName}]] | [[${detectIp}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 데이터유출 방어 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName             | 대상 서비스 명 (데이터유출)|
|_HEADER_ |eventName               | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName             | 대상 서비스 명 (데이터유출)|
|_HEADER_ |serverIp                | 대상 시스템 아이피 (에이전트)|
|_HEADER_ |serverName              | 대상 시스템 이름 (에이전트)|
|_HEADER_ |filterName              | 계정탈취 필터 이름|
|_HEADER_ |detectIp                | 공격자 아이피|
|_HEADER_ |logOrigin               | 전체 로그            |     

## 샘플로그
```
Nov 22 06:22:42 www.plura.io Plura 데이터 유출 방어\n데이터 유출 | 172.16.11.125 | QA-WAF-Stg | QA-데이터 정보 탈취-쿼리만 | 172.16.20.190 | -\n
```
