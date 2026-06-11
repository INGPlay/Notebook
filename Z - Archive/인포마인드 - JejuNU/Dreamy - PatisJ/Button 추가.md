---
date: 2025-03-17 17:53:39
created: 2025-03-17 17:53:33
categories:
- 인포마인드 - JejuNU / Dreamy - PatisJ
---

## Button 추가

<br>

```
// pos : 버튼위치 - beforeSearch, afterSearch, afterSave, afterDelete, afterExcel, afterPrint, afterExcepUpload<br>
	 * // width   : default - 명시하지 않을 경우 자동으로 설정됨.
	 * // tooltip : default - text와 동일하게 설정됨
	 * // role : search, delete, save 
	 * PatisJ.initExtButton("CT_GRIDTITLE01", "ext1", { pos : "befSearch", label : "신청", role : "save" });
	 * PatisJ.initExtButton("CT_GRIDTITLE01", "ext2", { pos : "befSearch", label : "신청", width : 60, tooltip : "신청", role : "save" });
```

<br>