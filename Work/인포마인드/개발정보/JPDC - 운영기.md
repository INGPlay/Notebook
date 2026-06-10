---
date: 2024-07-09 16:29:36
created: 2024-06-25 17:31:12
categories:
- 인포마인드 / 개발정보 - 인포마인드
---

## JPDC - 운영기

<br>

<br>

\*Tomcat 재실행 시 서버 종료 후에도 실행된 프로세스가 있으면 종료시키기

```
ps -ef | grep samdasoo
```

<br>

\*\*CMS 계정

```
infomng / info4787@
```

<br>

<br>

```
운영서버 URL
pos.jpdc.co.kr

비밀번호 초기화 시 비밀번호
jpdc7803300!@#


VPN 접속 URL
https://14.48.238.50
infomind001 / init2016!

서버 접근제어
infomind001 / init2016!

--------------------------------
SSH
WEB 서버
14.48.238.57

WAS/DB 서버
192.168.10.57

exmng / !jpdc3300
root / !jpdc3300

톰캣 실행 시 exmng 계정으로 할 것!
--------------------------------

MariaDB
192.168.10.57:3306/samdasoo
root / jpdc3300#@!
SAMDASOO / samda0318@@


SSL 인증서 비밀번호 : star.jpdc.co.kr
```

<br>

- DB 접속

```
mysql -h localhost samdasoo -u SAMDASOO -p
```

<br>

<br>