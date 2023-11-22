# 계정탈취 방어로그

## 계정탈취 방어 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterName}]] | [[${detectIp}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 계정탈취 방어 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName                 | 대상 서비스 명 (계정탈취)|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (계정탈취)|
|_HEADER_ |serverIp                    | 대상 시스템 아이피 (에이전트)|
|_HEADER_ |serverName                  | 대상 시스템 이름 (에이전트)|
|_HEADER_ |filterName                  | 계정탈취 필터 이름|
|_HEADER_ |detectIp                    | 공격자 아이피|
|_HEADER_ |logOrigin                   | 전체 로그            |     




## 샘플로그
```
Jun 16 02:25:14 www.plura.io Plura 계정탈취 방어\n계정탈취 | - | - | - | 0.0.0.0 | -\n
```
