---
date: 2025-08-01 10:14:22
created: 2025-08-01 10:13:16
categories:
- 인포마인드 - JejuNU / 사양 - JNU
---

## AXIS.EA\_DEPT\_V  

<br>

- 병주님도 부서 정렬할 때 AXIS.EA\_DEPT\_V 뷰 활용해서 하고 계시나요??

이거 나중에 얘기 나오면 일일이 고쳐주기 진짜 귀찮아서

```java
...
FROM TABLE A
LEFT
JOIN DEPT_V V /* AXIS.EA_DEPT_V의 DREAMY계정 ALIAS임. */
ON A.DEPT_CD = V.DEPT_CD
...
ORDER BY 
          ...
        , V.UNIV_SORT_SN
        , V.UNIV_CD
        , V.SSJ_SORT_SN
        , V.SSJ_CD
        , V.MJR_SORT_SN
        , V.MJR_CD
```

<br>

- 부서 순서가 중요한 화면이라면 ORDER BY는 딱 이거대로 해야해요