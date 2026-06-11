---
date: 2026-04-21 09:52:58
created: 2026-04-01 16:36:20
categories:
- 인포마인드 / 인수인계 - 인포마인드
---
## JDC 홈페이지

- 기업사보(칼리그램)
  - *최종적으로 올라가는 파일의 권한은 ‘hfapache:webadm’로 맞춰야 함)
  - 한국어

```java
mkdir /was/wcntr17/KO/ebook/$(date +%Y%m)
cd /was/wcntr17/KO/ebook/$(date +%Y%m)
mv /home/infouser/ebook/ebook.zip .
unzip ebook.zip
chown -R hfapache:webadm .
```

- 영문

```java
mkdir /was/wcntr17/KO/ebook_eng/$(date +%Y%m)
cd /was/wcntr17/KO/ebook_eng/$(date +%Y%m)
mv /home/infouser/ebook/ebook.zip .
unzip ebook.zip
chown -R hfapache:webadm .
```

- 썸네일 이미지 (양란 차장)

```java
cd /was/wcntr17/KO/img
chown hfapache:webadm /home/infouser/ebook/ebook_main.jpg
mv /home/infouser/ebook/ebook_main.jpg .
```

- 파일업로드/다운로드
  - Data/down 경로에 파일 올려놓고
  - 파일명에 맞추어 다운로드
