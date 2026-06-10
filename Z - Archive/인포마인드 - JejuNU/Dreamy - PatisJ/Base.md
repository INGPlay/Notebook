---
date: 2025-03-17 17:52:56
created: 2025-03-17 17:52:45
categories:
- 인포마인드 - JejuNU / Dreamy - PatisJ
---

## Base

<br>

<br>

```
PatisJ = new (cpr.core.Module.require("common/lib/PatisJ")).PatisJ(app, {
	service : "AHJ1001001",
	dataSet : {
		ds_grid01 : {
			requiredColumn  : ["SCYR", "SCTM", "STUNO", "SCA_CD", "MTELNO", "BANK_CD", "ACTNO", "DPSTR"],
			requiredText    : ["연도", "학기", "학번", "장학코드", "연락처", "은행명", "계좌번호", "예금주"],
			compareColumn   : ["SCYR", "SCTM", "STUNO", "SCA_CD", "ECLIPS_ENG_SCA_SN"],
			checkData		: true // 다른  탭(메뉴)으로 이동할 경우 유실방지 confirm할것인지~ 
		} 
	},
	grid : {
		DG_GRID00 : {checkbox : false, rownumber :  true, state :  true, sortable : false},
		DG_GRID01 : {checkbox : false, rownumber :  true, state :  true, sortable :  true},
	},
});  
```

<br>