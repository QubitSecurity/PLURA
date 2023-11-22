# 계정탈취 방어로그

## 계정탈취 방어 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterName}]] | [[${detectIp}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 계정탈취 방어 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (계정탈취)|
|_HEADER_ |filterName                  | 계정탈취 필터 이름|
|cs1|filterName                  | 계정탈취 필터 이름|
|src|detectIp                    | 공격자 아이피|
|dvc|serverIp                    | 대상 시스템 아이피 (에이전트)|
|dst|serverName                  | 대상 시스템 이름 (에이전트)|
|cs6|logOrigin                   | 전체 로그            |     




## 샘플로그
```
Jun 17 13:29:12 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(방어)계정탈취|-|-|end=Jun 17 2022 13:28:34 cs1=- cs2=- src=172.16.20.190 dvc=- dst=- cs6=-
```
