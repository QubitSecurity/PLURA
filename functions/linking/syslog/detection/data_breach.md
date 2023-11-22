# 데이터 유출 탐지로그

## 데이터 유출 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${logUri}]] | [[${filterCategoryName}]] | [[${filterName}]] | [[${detectIp}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 데이터 유출 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |serviceName                 | 대상 서비스 명 (데이터유출)|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (데이터유출)|
|_HEADER_ |serverIp                    | 대상 시스템 아이피 (에이전트)|
|_HEADER_ |logUri                      | 요청 경로 (URI)         |
|_HEADER_ |filterCategoryName          | 필터 카테고리 이름         |
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |detectIp                    | 공격자 아이피|
|_HEADER_ |logOrigin                   | 전체 로그            |     


## 샘플로그
```
Jun 16 02:05:44 www.plura.io Plura 데이터 유출 탐지\n데이터 유출 | 172.16.12.37 | /harry.asp | SQL 인젝션 | QA-POST ATTACK | 172.16.20.192 | {\&quot;Request\&quot;:\&quot;POST /ha rry.asp HTTP/1.1\&quot;,\&quot;Remote-addr\&quot;:\&quot;172.16.20.192\&quot;,\&quot;Request-date\&quot;:\&quot;16/Jun/2022:11:04:56.914 +0900\&quot;,\&quot;Uri\&quot;:\&quot;/har ry.asp\&quot;,\&quot;Method\&quot;:\&quot;POST\&quot;,\&quot;Host\&quot;:\&quot;172.16.12.37\&quot;,\&quot;Referer\&quot;:\&quot;http://172.16.12.37/\&quot;,\&quot;User-Agent\&quo t;:\&quot;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36\&quot;,\&quot;Req-Content-Type\&quot;:\&quot;application/ x-www-form-urlencoded\&quot;,\&quot;Req-Content-Length\&quot;:\&quot;36\&quot;,\&quot;Post-body\&quot;:\&quot;fname\=1%29+OR+NOT+1502%3D1502--+EXpp\&quot;,\&quot;Status\&quot;:\&q uot;200\&quot;,\&quot;Cache-Control\&quot;:\&quot;private\&quot;,\&quot;Resp-Content-Type\&quot;:\&quot;text/html\&quot;,\&quot;Resp-Content-Length\&quot;:\&quot;59\&quot;,\&quot; Server\&quot;:\&quot;Microsoft-IIS/10.0\&quot;,\&quot;ModPlura-version\&quot;:\&quot;IIS/5.5.3(64)\&quot;}\n

```
