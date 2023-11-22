# 웹방화벽 방어로그

## 웹방화벽 방어 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterCategoryName}]] | [[${filterName}]] | [[${detectIp}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 웹방화벽 방어 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName                 | 대상 서비스 명 (웹방화벽)|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (웹방화벽)|
|_HEADER_ |serverIp                    | 대상 시스템 아이피 (에이전트)|
|_HEADER_ |serverName                  | 대상 시스템 이름 (에이전트)|
|_HEADER_ |filterCategoryName          | 필터 카테고리 이름     |
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |detectIp                    | 공격자 아이피|
|_HEADER_ |logOrigin                   | 전체 로그            |


## 샘플로그
```

Jun 16 03:38:45 www.plura.io Plura 웹방화벽 방어\n웹방화벽 | 172.16.12.57 | CentOS7 | SQLI | 취약한 컬럼 개수 탈취 | 172.16.20.192 | -\n


```
