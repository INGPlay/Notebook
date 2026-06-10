---
date: 2024-02-20 09:07:53
created: 2024-02-20 09:06:21
categories:
- 인포마인드 / 개발정보 - 인포마인드
---

## JTP - 접속 방법

<br>

```
접속방법
1. SSL VPN 접속(https://sslvpn.jejutp.or.kr/user2)
2. DB Safer 접속(제주테크노파크(내부망)_DBSAFERAGENT_[3.2.36.1](O).exe)
3. SSH 접속

SSL VPN
URL : https://sslvpn.jejutp.or.kr/user2
ID/PW : infomind / jejutp@4787


DB Safer
ID
infomind12
infomind13
infomind14
PW
jtp_mzc1!


WEB 서버
Public IP : 211.57.84.64
Private IP : 172.25.71.62 : 10022
SSH Key : JJ-TP-D-JEUS
id  : centos


SSL 설정 위치(여기에 SSL 인증서 경로만 바꿔주면 됨)
/etc/httpd/conf/httpd.conf

SSL 인증서 위치
/etc/httpd/ssl_set/


WAS 서버
Public IP : 211.57.84.64
Private IP : 172.25.73.62 : 10022
SSH Key : JJ-TP-P-JEUS
id  : centos

톰캣 위치 : /data/jtpcms/bin/apache-tomcat-9.0.71/
배포위치 : /data/jtpcms/www


DB 서버
Public IP : 211.57.84.64
Private IP : 172.25.73.63 : 10022
SSH Key : JJ-TP-P-JEUS
id  : centos

mysql 접속 방법
sudo -s
mysql

DB 접속 정보
172.25.73.63 : 3306 / jtpcms1
jtpcms1 / jtpcms1
```

<br>