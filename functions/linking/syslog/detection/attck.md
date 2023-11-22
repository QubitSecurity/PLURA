# 마이터 탐지로그

## 마이터 메시지 템플릿 구조
```
CEF:0|QubitSecurity|Plura|5|([[${eventName}]])[[${serviceName}]]|[[${filterName}]]|[[${mitrePlatformName}]]|end=[[${registerDate}]] cs1=[[${filterName}]]([# th:if="${mitreTechniqueSubId == '-' or mitreTechniqueSubId == 'NONE'}"][[${mitreTechniqueId}]][/][# th:unless="${mitreTechniqueSubId == '-' or mitreTechniqueSubId == 'NONE'}"][[${mitreTechniqueId}]].[[${mitreTechniqueSubId}]][/]) cs2=[[${filterCategoryName}]] src=[[${detectIp}]] dvc=[[${serverIp}]] dst=[[${serverName}]][# th:if="${isUseLogOrigin == '1'}"] cs6=[[${logOrigin}]][/]
```

## 마이터 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (마이터)|
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |mitrePlatformName           | 마이터 플랫폼 이름 |
|end|registerDate                | 이벤트 발생시간|
|cs1|filterName                  | 필터 이름|
|cs2|filterCategoryName          | 필터 카테고리 이름     |
|src|detectIp                    | 공격자 아이피|
|dvc|serverIp                    | 대상 시스템 아이피 (에이전트)|
|dst|serverName                  | 대상 시스템 이름 (에이전트)|
|cs6|logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 12:45:00 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(탐지)마이터|계정 액세스 제거 [T1531]|Linux|end=Jun 16 2022 12:28:59 cs1=계정 액세스 제거 [T1531](T1531) cs2=마이터 어택 src=- dvc=- dst=- cs6=-

```
