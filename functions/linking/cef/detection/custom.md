# 사용 로그

## 사용 메시지 템플릿 구조
```
CEF:0|QubitSecurity|Plura|5|[[${eventType}]]|[[${eventName}]]|0|end=[[${registerDate}]] cs1=[[${userActionCategoryGroupName}]] cs2=[[${userActionCategoryGroupName}]]/[[${userActionCategoryName}]] cs5=[[${userName}]]
```

## 사용 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventType                   | 대상 서비스 타입 |
|_HEADER_ |eventName                   | 대상 서비스 명 (사용로그)|
|_HEADER_ |0                           | 고정|
|end|registerDate                | 이벤트 발생시간|
|cs1|userActionCategoryGroupName | 사용로그 이벤트 카테고리 명 |
|cs2|userActionCategoryName          | 사용로그 이벤트 명     |
|cs5|userName                   | 사용자 명            |     


## 샘플로그
```
Jun 17 11:11:58 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5||사용로그|0|end=Jun 17 2022 11:11:55 cs1=멤버 cs2=멤버/로그인 cs5=MIKE

```
