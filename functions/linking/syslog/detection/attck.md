# 마이터 탐지로그

## 마이터 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [# th:if="${mitreTechniqueSubId == '-' or mitreTechniqueSubId == 'NONE'}"][[${mitreTechniqueId}]][/][# th:unless="${mitreTechniqueSubId == '-' or mitreTechniqueSubId == 'NONE'}"][[${mitreTechniqueId}]].[[${mitreTechniqueSubId}]][/] | [[${mitrePlatformName}]] | [[${mitreTacticsName}]] | [[${mitreTechniqueName}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 마이터 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName                 | 대상 서비스 명 (마이터)|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (마이터)|
|_HEADER_ |mitreTechniqueId            | 마이터 기술 아이디|
|_HEADER_ |mitreTechniqueSubId         | 마이터 하위 기술 아이디|
|_HEADER_ |mitrePlatformName           | 마이터 플랫폼 이름 |
|_HEADER_ |mitreTacticsName            | 마이터 전술 이름|
|_HEADER_ |mitreTechniqueName          | 마이터 기술 이름|
|_HEADER_ |logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 02:07:44 www.plura.io Plura 마이터 탐지\n마이터 | T1531 | Linux | 영향 | 계정 액세스 제거 | -\n

```
