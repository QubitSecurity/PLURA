# 상관분석 탐지로그

## 상관분석 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterName}]] | [[${detectRatio}]]%[# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 상관분석 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName                 | 대상 서비스 명 (상관분석)|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (상관분석)|
|_HEADER_ |serverIp                    | 대상 시스템 아이피 (에이전트)|
|_HEADER_ |serverName                  | 대상 시스템 이름 (에이전트)|
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |detectRatio                 | 탐지율(%) |
|_HEADER_ |logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 02:08:29 www.plura.io Plura 상관분석 탐지\n상관분석 | 172.16.12.40 | Harry-LP-L | - | 90% | -\n

```
