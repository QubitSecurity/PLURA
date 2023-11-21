# 웹 탐지로그

## 웹 메시지 템플릿 구조
```
CEF:0|QubitSecurity|Plura|5|([[${eventName}]])[[${serviceName}]]|[[${filterName}]]|[[${filterRiskLevel}]]|end=[[${registerDate}]] cs1=[[${logQuery}]] cs2=[[${logUri}]] cs3=[[${logReferer}]] cs4=[[${logRequestBody}]] cs5=[[${filterCategoryName}]] Name=[[${filterName}]] request=[[${logUri}]] src=[[${detectIp}]] dvc=[[${serverIp}]] dst=[[${serverName}]] dhost=[[${logHost}]] requestMethod=[[${logMethod}]] requestCookies=[[${logCookie}]] requestClientApplication=[[${logUserAgent}]] categoryOutcome=[[${logStatus}]] requestContext=[[${logRequestContentType}]] sourceTranslatedAddress=[[${logXForwardedFor}]] [# th:if="${logBlocked == '1'}"]act=BLOCK[/][# th:if="${logBlocked == '0'}"]act=DETECT[/] in=[[${logRequestContentLength}]] out=[[${logResponseContentLength}]][# th:if="${isUseLogOrigin == '1'}"] cs6=[[${logOrigin}]][/]
```

## 웹 메시지 파라미터 정의
|필드명| 변 수 명                       |  내용                                   |
|-----|----------------------------|----------------------------------------|
|_HEADER_ |eventName                   | 메시지 발생 구분 ( 탐지/방어/사용자로그 등)|
|_HEADER_ |serviceName                 | 대상 서비스 명 (웹탐지)|
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
Jun 16 12:44:30 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(탐지)웹|컬럼 데이터 탈취|4|end=Jun 16 2022 12:28:29 cs1=action\=data_management&amp;cpmvc_do_action\=mvparse&amp;f\=datafeed&amp;method\=remove&amp;rruleType\=del_only&amp;calendarId\=1%20AND%20EXTRACTVALUE%286584%2CCONCAT%280x5c%2C0x716a627171%2C%28SELECT%20MID%28%28IFNULL%28CAST%28user_pass%20AS%20NCHAR%29%2C0x20%29%29%2C22%2C21%29%20FROM%20wordpress.wp_users%20ORDER%20BY%20user_pass%29%2C0x717a6a7871%29%29 cs2=/wordpress/index.php cs3=- cs4=- cs5=SQLI Name=컬럼 데이터 탈취 request=/wordpress/index.php src=172.16.20.192 dvc=172.16.12.40 dst=Harry-LP-L dhost=172.16.12.40 requestMethod=GET requestCookies=- requestClientApplication=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36 categoryOutcome= requestContext=- sourceTranslatedAddress=- act=DETECT in=- out=- cs6={\&quot;Host\&quot;:\&quot;172.16.12.40\&quot;,\&quot;User-Agent\&quot;:\&quot;Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36\&quot;,\&quot;Remote-addr\&quot;:\&quot;172.16.20.192\&quot;,\&quot;Request-date\&quot;:\&quot;16/Jun/2022:12:43:35.586 +0900\&quot;,\&quot;Method\&quot;:\&quot;GET\&quot;,\&quot;Uri\&quot;:\&quot;/wordpress/index.php\&quot;,\&quot;Request\&quot;:\&quot;GET /wordpress/?action\=data_management&amp;cpmvc_do_action\=mvparse&amp;f\=datafeed&amp;method\=remove&amp;rruleType\=del_only&amp;calendarId\=1%20AND%20EXTRACTVALUE%286584%2CCONCAT%280x5c%2C0x716a627171%2C%28SELECT%20MID%28%28IFNULL%28CAST%28user_pass%20AS%20NCHAR%29%2C0x20%29%29%2C22%2C21%29%20FROM%20wordpress.wp_users%20ORDER%20BY%20user_pass%29%2C0x717a6a7871%29%29 HTTP/1.1\&quot;,\&quot;ModPlura-version\&quot;:\&quot;Apache/5.5.3(2.4)\&quot;,\&quot;Status\&quot;:\&quot;200\&quot;,\&quot;Resp-Content-Length\&quot;:\&quot;75\&quot;}

```
