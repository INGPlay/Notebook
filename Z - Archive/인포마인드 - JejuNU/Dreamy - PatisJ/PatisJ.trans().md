---
date: 2025-03-21 13:13:27
created: 2025-03-18 11:24:25
categories:
- 인포마인드 - JejuNU / Dreamy - PatisJ
---

## PatisJ.trans()

<br>

```
function selectCollNm() {
	
	let p = PatisJ.getParam()
	
	PatisJ.trans({
		service	 : "DDO4010204",
		method   : "selectCollNm",
		param 	 : {
			CAMP_SE			: p["CAMP_SE"],
			COLL_SE			: p["COLL_SE"],
			COLL_YR			: p["YR"],
		},
		inDatas  : {}, 
		outDatas : {
			ds_out01		: "ds_coll_nm"
		},
		callback : "selectCollNmAfter:selectCollNm"
	});

}

function selectCollNmAfter(){

	app.lookup("S_COLL_NM").initCreate();
	app.lookup("S_COLL_NM").setComboDataset(app.lookup("ds_coll_nm"));

}
```

<br>

- service
    - Java 서비스 파일
- method
    - Java 서비스 함수
- param
    - 추가 파라미터
- inDatas
    - DataSet 입력값
- outDatas
    - Java 서비스에서 리턴한 객체
        - ds\_out01, ds\_out02, ... : DataSet 대상
        - ds\_out : Grid 대상

- callback
    - 콜백 함수