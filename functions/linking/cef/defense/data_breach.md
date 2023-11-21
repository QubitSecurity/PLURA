# 데이터유출 방어로그

## 데이터유출 방어 메시지 템플릿 구조
```
CEF:0|QubitSecurity|Plura|5|([[${eventName}]])[[${serviceName}]]|[[${filterName}]]|[[${filterRiskLevel}]]|end=[[${registerDate}]] cs1=[[${filterName}]] cs2=[[${filterCategoryName}]] src=[[${detectIp}]] dvc=[[${serverIp}]] dst=[[${serverName}]][# th:if="${isUseLogOrigin == '1'}"] cs6=[[${logOrigin}]][/]
```

## 데이터유출 방어 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName               | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName             | 대상 서비스 명 (데이터유출)|
|_HEADER_ |filterName              | 계정탈취 필터 이름|
|_HEADER_ |filterRiskLevel         | 계정탈취 필터 위험도|
|end|registerDate                  | 이벤트 발생시간|
|cs1|filterName                    | 계정탈취 필터 이름|
|cs2|filterCategoryName            | 계정탈취 카테고리 이름     |
|src|detectIp                      | 공격자 아이피|
|dvc|serverIp                      | 대상 시스템 아이피 (에이전트)|
|dst|serverName                    | 대상 시스템 이름 (에이전트)|
|cs6|logOrigin                     | 전체 로그            |     

## 샘플로그
```
Jun 17 13:29:12 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(방어)데이터유출|데이터유출 필터|-|end=Jun 17 2022 13:28:34 cs1=- cs2=- src=172.16.20.190 dvc=- dst=- cs6=-
```
