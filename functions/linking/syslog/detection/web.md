# 웹 탐지로그

## 웹 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterCategoryName}]] | [[${filterName}]] | [[${detectDescription}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 웹 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName                 | 대상 서비스 명 (웹)|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (웹)|
|_HEADER_ |serverIp                    | 대상 시스템 아이피 (에이전트)|
|_HEADER_ |serverName                  | 대상 시스템 이름 (에이전트)|
|_HEADER_ |filterCategoryName                   | 필터 카테고리 이름         |
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |detectDescription           | |
|_HEADER_ |logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 02:49:30 www.plura.io Plura 웹 탐지\n웹 | 172.31.36.185 | WEB:AWS | LFI | 제한된 파일 액세스 시도 | /.env\n

```
