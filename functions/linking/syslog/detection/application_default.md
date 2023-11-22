# 응용프로그램 탐지로그

## 응용프로그램 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterName}]] | [[${logConfigPath}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 응용프로그램 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName                 | 대상 서비스 명 (응용프로그램 원본)|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (응용프로그램 원본)|
|_HEADER_ |serverIp                    | 대상 시스템 아이피 (에이전트)|
|_HEADER_ |serverName                  | 대상 시스템 이름 (에이전트)|
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |logConfigPath               | 로그 발생 파일 경로|
|_HEADER_ |logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 02:02:59 www.plura.io Plura 응용프로그램 원본 탐지\n응용프로그램 원본 | 172.16.12.40 | Harry-LP-L | QA-ceelog | /var/log/plura/ceelog-127.0.0.1.log | \&quot;Removed slice U ser Slice of root.\&quot;}}\n
```
