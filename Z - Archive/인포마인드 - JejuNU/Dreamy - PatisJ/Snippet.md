---
date: 2026-06-10 21:48:41
created: 2025-03-18 13:39:59
categories:
- 인포마인드 - JejuNU / Dreamy - PatisJ
---

## Snippet

<br>

```
	PatisJ = new (cpr.core.Module.require("common/lib/PatisJ")).PatisJ(app, {
		service : serviceName,
		grid : {
			DG_GRID01 : {checkbox : , rownumber : , state : , sortable : },
		},
	});
```

<br>

<br>

```
	let p = PatisJ.getParam();

	PatisJ.trans({
		// service	 : serviceName,
		method   : methodName,
		param    : {
			// CAMP_SE		:  p["S_CAMP_SE"],
			CAMP_SE 	: app.getHostProperty("initValue")["GB1"]
		},
		outDatas : {
			// ds_out : "DG_GRID01"
			ds_out01  	: "",		//
			ds_out02  	: "",		//
			ds_out03  	: "",		//
		},
		callback : "Form_saveAfter:serviceId"
	});
```

<br>