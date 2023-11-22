# 사용자 로그

## 사용자 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterName}]] | [[${filterCategoryName}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 사용자 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName                   | 대상 서비스 명 (사용로그)|
|_HEADER_ |serviceName                 | |
|_HEADER_ |serverIp                    | 대상 시스템 아이피 (에이전트)|
|_HEADER_ |serverName                  | 대상 시스템 이름 (에이전트)|
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |filterCategoryName          | 사용로그 이벤트 명     |
|_HEADER_ |logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 03:38:45 www.plura.io Plura 사용로그\n네트워크 필터 | 네트워크 필터/수정 | Harry(LP) | Configuration 저장\n

```
