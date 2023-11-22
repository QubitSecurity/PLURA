# 사용 로그

## 사용 메시지 템플릿 구조
```
[[${eventType}]] [[${eventName}]]\n[[${userActionCategoryGroupName}]] | [[${userActionCategoryGroupName}]]/[[${userActionCategoryName}]] | [[${userName}]] | [[${detectDescription}]]\n
```

## 사용 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventType                         | 대상 서비스 타입 |
|_HEADER_ |eventName                         | 대상 서비스 명 (사용로그)|
|_HEADER_ |userActionCategoryGroupName       | 사용로그 이벤트 카테고리 명|
|_HEADER_ |userActionCategoryName            | 사용로그 이벤트 명|
|_HEADER_ |userName                          | 사용자 명     |
|_HEADER_ |detectDescription                 | 설명            |     


## 샘플로그
```
Jun 16 03:38:45 www.plura.io Plura 사용로그\n네트워크 필터 | 네트워크 필터/수정 | Harry(LP) | Configuration 저장\n

```
