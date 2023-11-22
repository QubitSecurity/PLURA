# 웹 탐지로그

## 웹 메시지 템플릿 구조
```
[[${serviceName}]] [[${eventName}]]\n[[${serviceName}]] | [[${serverIp}]] | [[${serverName}]] | [[${filterCategoryName}]] | [[${filterName}]] | [[${detectDescription}]][# th:if="${isUseLogOrigin == '1'}"] | [[${logOrigin}]][/]\n
```

## 웹방화벽 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (웹방화벽)|
|_HEADER_ |filterName                  | 필터 이름|
|_HEADER_ |filterRiskLevel             | 필터 위험도|
|end|registerDate                | 이벤트 발생시간|
|cs1|logQuery                  | 요청 쿼리 |
|cs2|logUri          | 요청 경로 (URI)     |
|cs3|logReferer                   | REFERER            |
|cs4|logRequestBody                   | REQUEST-BODY            |
|cs5|filterCategoryName                   | 필터 카테고리 이름         |
|Name|filterName                   | 필터 이름         |
|request|logUri                   | 요청 경로 (URI)         |
|src|detectIp                    | 공격자 아이피|
|dvc|serverIp                    | 대상 시스템 아이피 (에이전트)|
|dst|serverName                  | 대상 시스템 이름 (에이전트)|
|dhost|logHost                    | 대상 시스템 호스트 (에이전트)|
|requestMethod|logMethod                   | 요청 Method            |
|requestCookies|logCookie                   | 요청 Cookie            |
|requestClientApplication|logUserAgent                   | 사용자 Agent            |
|categoryOutcome|logStatus                   | 응답 HTTP STATUS            |
|requestContext|logRequestContentType                   | 요청 CONTENT-TYPE            |
|sourceTranslatedAddress|logXForwardedFor               | X-FORWARDED-FOR           |
|act|                | 'BLOCK' OR 'DETECT'           | |
|in|logRequestContentLength           | 요청 크기 |
|out|logRequestContentLength           | 응답 크기 |
|cs6|logOrigin                   | 전체 로그            |


## 샘플로그
```
Jun 16 12:45:00 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(탐지)웹방화벽|Script 태그 공격|4|end=Jun 16 2022 12:19:26 cs1=%3Cscript%3Ealert(%22xss%22)%3C/script%3E cs2=/wordpress/ cs3=- cs4=- cs5=XSS Name=Script 태그 공격 request=/wordpress/ src=172.16.20.192 dvc=172.16.12.57 dst=CentOS7 dhost=172.16.12.57 requestMethod=GET requestCookies=- requestClientApplication=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36 categoryOutcome= requestContext=- sourceTranslatedAddress=- act=BLOCK in=- out=- cs6={\&quot;Remote-addr\&quot;:\&quot;172.16.20.192\&quot;,\&quot;Host\&quot;:\&quot;172.16.12.57\&quot;,\&quot;Request\&quot;:\&quot;GET /wordpress/?%3Cscript%3Ealert(%22xss%22)%3C/script%3E HTTP/1.1\&quot;,\&quot;Method\&quot;:\&quot;GET\&quot;,\&quot;Uri\&quot;:\&quot;/wordpress/\&quot;,\&quot;User-Agent\&quot;:\&quot;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36\&quot;,\&quot;Request-date\&quot;:\&quot;16/Jun/2022:12:44:12.300 +0900\&quot;,\&quot;Status\&quot;:\&quot;406\&quot;,\&quot;ModPlura-version\&quot;:\&quot;WAF/5.7.2(1.15.8)-114.rule\&quot;,\&quot;Resp-Content-Length\&quot;:\&quot;0\&quot;,\&quot;Blocked\&quot;:\&quot;1\&quot;}

```
