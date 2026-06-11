---
date: 2025-03-13 11:24:01
created: 2025-03-13 11:14:52
categories:
- 인포마인드 - JejuNU / Dreamy - JDot
---

## titleList

<br>

```
let J;

let title01 = {
	type	: "info",
	id	: "TITLE01",
	buttons: ["ext1", "ext2", "ext3"],
    buttonsDtl: {
        ext1: {
            text: "SMS발송",
            role: "save",
            theme: "ext"
        },
        ext2: {
            text: "SMS발송이력",
            role: "save",
            theme: "ext"
        },
        ext3: {
            text: "EMAIL발송",
            role: "save",
            theme: "ext"
        },
    },
    onExt1: function() {

    },
    onExt2: function() {

    },
    onExt3: function() {

    },
}

let title02 = {
	type	: "grid",
	id	: "TITLE02",
	gridId	: "GRID02",
	dataId	: "DATA02",
}

let title03 = {
	type	: "grid",
	id	: "TITLE03",
	gridId	: "GRID03",
	dataId	: "DATA03",
}

let title04 = {
	type	: "grid",
	id	: "TITLE04",
	gridId	: "GRID04",
	dataId	: "DATA04",
}

let title05 = {
	type	: "info",
	id	: "TITLE05",
}

let title06 = {
	type	: "grid",
	id	: "TITLE06",
	gridId	: "GRID06",
	dataId	: "DATA06",
}

let title07 = {
	type	: "grid",
	id	: "TITLE07",
	gridId	: "GRID07",
	dataId	: "DATA07",
}

let title08 = {
	type	: "grid",
	id	: "TITLE08",
	gridId	: "GRID08",
	dataId	: "DATA08",
}

let title09 = {
	type	: "grid",
	id	: "TITLE09",
	gridId	: "GRID09",
	dataId	: "DATA09",
}

let title10 = {
	type	: "grid",
	id	: "TITLE10",
	gridId	: "GRID10",
	dataId	: "DATA10",
}

let title11 = {
	type	: "info",
	id	: "TITLE11",
}

let title99 = {
	type	: "grid",
	id	: "TITLE99",
	gridId	: "GRID99",
	dataId	: "DATA01",
	gridDtl: {
            addCols: ["STATE", "NO", "CHECK"],
            sortCols: [],
        },
}

function App_load(e){
	J = new (cpr.core.Module.require("common/lib/Jdot_v11")).Jdot(app, {
		conf		: config,
		titleList  	: [title01, title02, title03, title04, title05, title06, title07, title08, title09, title10, title11, title99],
		fileList	: [file01],  
		after : function(code, msg){ 

		}
	}); 
	exports.J = J;
}
```

<br>

- type (string)
    - info
    - grid
- id (string)
    - title과 매칭되는 화면 컴포넌트 id
- buttons (string array)
    - JTitle 버튼 설정
    - 버튼을 등록한다
- buttonsDtl (object)
    - 버튼 정보
        - text : 버튼 표시값
        - role : 권한
        - theme : 아이콘