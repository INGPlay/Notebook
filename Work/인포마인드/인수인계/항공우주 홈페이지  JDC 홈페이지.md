---
date: 2026-04-10 17:48:25
created: 2026-03-12 17:24:56
categories:
- 인포마인드 / 인수인계 - 인포마인드
---

## 항공우주 홈페이지 / JDC 홈페이지

<br>

<br>

- 홈페이지 접속 시 가상화 필요 (로그인 2번, 첫번째 로그인 시 안치홍 차장 호출)
    - 항공우주 홈페이지
        - 사업관리 : 류형렬 부장
    - JDC 홈페이지
        - 사업관리 : 강 이사

<br>

- MSP - 컨텐츠 브릿지 : WEB, WAS, DB 관리

<br>

- 배포
    - 계정
        - drvjeju : 배포
        - hftomcat : 서버 재기동
    - 경로
        - jam\_eng/jamwas/ : 항공우주
        - jam\_eng/jwctrl/ : JDC
        - jdcan\_admin/ : 항공우주 관리자?

<br>

<br>

- DB 4개에 연결 되고 있음 (자체 1 + IAM 1 + POS 1 + SMS 1)
    - IAM : 계정관련
    - 실제 데이터는 POS에 쌓인다

<br>

<br>

- 보도자료 날짜 수정
    - jamdb
        - T\_NOTICE 테이블 - CRE\_DTT, UPD\_DTT 컬럼 - 업데이트

```java
SELECT
	a.NO_SEQ
	, a.DOM_CD
	, a.BO_SEQ
	, a.NO_TITLE
	, a.NO_CONTENT
	, NVL(a.NO_READ_CNT, 0) AS NO_READ_CNT
	, a.NO_PIN_YN
	, a.NO_SECRET_YN
	, a.NO_STAT
	, a.NO_VIDEO
	, a.NO_ANSWER_STAT
	, a.NO_ANSWER_ID
	, a.NO_ANSWER_NM
	, a.NO_ANSWER_DTT
	, a.NO_ANSWER_READ_CNT
	, a.NO_ANSWER_TITLE
	, a.NO_ANSWER_COMMENT
	, a.ADD1
	, a.ADD2
	, a.ADD3
	, a.ADD4
	, a.ADD5
	, a.CRE_DTT
	, a.CRE_USR_ID
	, a.CRE_USR_NM
	, a.CRE_USR_IP
	, a.UPD_DTT
	, a.UPD_USR_ID
	, a.UPD_USR_NM
	, a.UPD_USR_IP
	, a.DEL_REASON
	, 0 rnum
FROM
	T_NOTICE a
WHERE
	NO_SEQ = '{게시판SEQ}'
	AND a.NO_STAT = '0010'

```

<br>