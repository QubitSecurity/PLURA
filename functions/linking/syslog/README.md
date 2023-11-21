README

▣ 라이브 Syslog Sample

상관분석 / RFC5424 / LF(\n)
```
Jun  8 08:02:40 www.plura.io Plura 보안탐지 | 1건\n상관분석 | 172.16.12.40 | Harry-LP-L | Mike-생성삭제 | 90%\n
Jun  8 17:02:50 ip-172-31-42-225 bash[17228]: root : /var/log : grep --color=auto -E "^(?=.*172\.16\.)((?=Plura.*사용)|(?=Plura.*방어)).*$"
```

데이터유출 / RFC3164 / ASCII(#012)

```
Jun  8 08:08:30 www.plura.io Plura 보안탐지 | 4건#012데이터 유출 | 172.16.12.40 | /wordpress/index.php | SQL 인젝션 | QA-데이터 정보 탈취-쿼리만-적용OFF | 172.16.20.192#012데이터 유출 | 172.16.12.40 | /wordpress/index.php | SQL 인젝션 | 데이터 정보 탈취 | 172.16.20.192#012데이터 유출 | 172.16.12.40 | /wordpress/index.php | SQL 인젝션 | QA-데이터 정보 탈취-쿼리만-적용OFF | 172.16.20.192#012데이터 유출 | 172.16.12.40 | /wordpress/index.php | SQL 인젝션 | 데이터 정보 탈취 | 172.16.20.192
```

웹 / CEF / Space / 본문

```
Jun  8 17:16:11 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(탐지)웹|컬럼 데이터 탈취|4|end=Jun 08 2022 17:16:11 cs1=action=data_management&cpmvc_do_action=mvparse&f=datafeed&method=remove&rruleType=del_only&calendarId=1%20AND%20EXTRACTVALUE%286584%2CCONCAT%280x5c%2C0x716a627171%2C%28SELECT%20MID%28%28IFNULL%28CAST%28user_pass%20AS%20NCHAR%29%2C0x20%29%29%2C22%2C21%29%20FROM%20wordpress.wp_users%20ORDER%20BY%20user_pass%29%2C0x717a6a7871%29%29 cs2=1+AND+EXTRACTVALUE%286584%2CCONCAT%280x5c%2C0x716a627171%2C%28SELECT+MID%28%28IFNULL%28CAST%28user_pass+AS+NCHAR%29%2C0x20%29%29+%2866+characters+omitted%29 cs5=SQLI ERROR BASE request=/wordpress/index.php src=172.16.20.192 dvc=172.16.12.40 dst=Harry-LP-L dhost=172.16.12.40 requestMethod=GET requestClientApplication=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36 categoryOutcome=200 act=DETECT in=0 out=75 cs6={\"Host\":\"172.16.12.40\",\"User-Agent\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.0.0 Safari/537.36\",\"Remote-addr\":\"172.16.20.192\",\"Request-date\":\"08/Jun/2022:17:15:28.991 +0900\",\"Method\":\"GET\",\"Uri\":\"/wordpress/index.php\",\"Request\":\"GET /wordpress/?action\=data_management&cpmvc_do_action\=mvparse&f\=datafeed&method\=remove&rruleType\=del_only&calendarId\=1%20AND%20EXTRACTVALUE%286584%2CCONCAT%280x5c%2C0x716a627171%2C%28SELECT%20MID%28%28IFNULL%28CAST%28user_pass%20AS%20NCHAR%29%2C0x20%29%29%2C22%2C21%29%20FROM%20wordpress.wp_users%20ORDER%20BY%20user_pass%29%2C0x717a6a7871%29%29 HTTP/1.1\",\"ModPlura-version\":\"Apache/5.5.3(2.4)\",\"Status\":\"200\",\"Resp-Content-Length\":\"75\"}
```

시스템 / CEF / Space

```
Jun  8 17:17:56 211.43.190.184 plura.notice: CEF:0|QubitSecurity|Plura|5|(탐지)시스템|계정 삭제|4|end=Jun 08 2022 17:17:56 cs1=계정 삭제 dvc=172.16.12.40 dst=Harry-LP-L
```

마이터어택 / RFC5424 / ASCII(#012)

```
Jun  8 08:20:01 www.plura.io Plura 보안탐지 | 4건#012마이터 | T1021.004 | macOS,Linux | TA0008 | SSH | 0#012마이터 | T1048 | Windows,macOS,Linux | TA0010 | 대체 프로토콜을 통한 유출 | 0#012마이터 | T1053.006 | Linux | TA0002 | 시스템 타이머 | 0#012마이터 | T1053.003 | macOS,Linux | TA0002 | Cron | 0
```
