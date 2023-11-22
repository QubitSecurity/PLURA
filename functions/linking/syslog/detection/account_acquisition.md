# 계정탈취 탐지로그

## 계정탈취 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${detectPath}]] | [[${filterCategoryName}]] | [[${filterName}]] | [[${detectIp}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 계정탈취 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName                 | 대상 서비스 명 (계정탈취)|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (계정탈취)|
|_HEADER_ |detectPath                  | 계정탈취 대상 공격경로|
|_HEADER_ |filterCategoryName          | 계정탈취 카테고리 이름|
|_HEADER_ |filterName                  | 계정탈취 필터 이름|
|_HEADER_ |detectIp                    | 공격자 아이피|
|_HEADER_ |logOrigin                   | 전체 로그            |     
 
 
## 샘플로그
```
Jun 16 02:28:30 www.plura.io Plura 계정탈취 탐지\n계정탈취 | Host: 172.16.12.40, Path: /wordpress/wp-login.ph1 | 볼륨 메트릭(가변) | QA-볼륨가변-실패-POST-AND | 0.0.0.0 | -\n
```
