---
date: 2025-05-09 09:18:38
created: 2025-03-12 11:11:09
categories:
- 인포마인드 - JejuNU / Dreamy - JDot
---

## config

<br>

```
let J;
let g_camp_se =  app.getHostProperty("initValue")["GB1"];

let config = {
	service			: "BCM6040105",
	leaveCheckData 	: ["DATA01"],
	initMethod		: ["selectList02"],
	initDatasParam  : {"CAMP_SE" : g_camp_se},
	initDatas		: ["DATA02"],  
	codeList		: ["CRT_TYPE_SE", "CONSLT_FLD_SE", "CONSLT_STTS_SE", "SCGD"], 
	comboList		:
		[
                       { id : "S_PRGRM_SN", emptyLabel : "전체",	type : "DATASET", 		dataId	: "DATA02"},
			{ id : "S_CRT_TYPE_SE", emptyLabel : "전체",	type : "CODE", 		codeName	: "CRT_TYPE_SE"},
			{ id : "S_CONSLT_FLD_SE", emptyLabel : "전체",	type : "CODE", 		codeName	: "CONSLT_FLD_SE"},
			{ id : "S_CONSLT_STTS_SE", emptyLabel : "전체",	type : "CODE", 		codeName	: "CONSLT_STTS_SE"},
			{ id : "S_SCGD", emptyLabel : "전체",	type : "CODE", 		codeName	: "SCGD"},
			{ id : "G_CONSLT_STTS_SE", emptyLabel : "선택",	type : "CODE", 		codeName	: "CONSLT_STTS_SE"},
		],
	buttons 	: ["search", "new", "ext1", "save"],
	buttonsDtl: {
            ext1: {
                text: "그룹신규",
                role: "save",
                theme: "new"
            },
        },
	onSearch : function(){ 

	},
	onNew : function(){ 

	},
	onExt1: function() {

        },
	onSave : function(){ 

	},
}

/*
  ...
*/

function App_load(e){
	J = new (cpr.core.Module.require("common/lib/Jdot_v11")).Jdot(app, {
		conf		: config,
		titleList  	: [title01], 
		after : function(code, msg){
			
		}
	}); 
	exports.J = J;
}
```

- service (string or array)
    - ‘patis.server’ 경로에 있는 java 파일
    - 서비스 의존성 주입 역할
- leaveCheckData (string array)
    - 정확히는 모르는데, 추측하자면 페이지를 나갈 때 입력된 Model에 변경된 값이 있으면 체크하는 기능을 사용하는 거?
- initMethod (string or array)
    - 처음에 실행할 java 서비스 메소드 등록
- initDatasParam ( object )
    - initMethod에 보낼 파라미터 등록
- initDatas (string or array)
    - 초기화할 Dataset 등록
- codeList (string or array)
    - 공통 코드에서 가져올 코드 등록
- comboList (object array)
    - 데이터를 화면의 콤보박스와 매칭
        - id : 화면 컴포넌트 ID
        - emptyLabel : 기본 표시값
        - type :
            - CODE
                - codeName : ‘codeList’ 에서 가져온 코드
            - DATASET
                - dataId : ‘initData’에서 초기화한 데이터셋 (쿼리 alias가 ‘CODE’와 ‘DATA’로 구성되야 함)
                    - ```
SELECT
	PRGRM_SN AS CODE
	,PRGRM_NM AS DATA
FROM
	DREAMY.POT_AFE_PRGRM_APLY_V
```

            - YN
                - ...

- buttons (string array)
    - JHeader 버튼 설정
    - “search”, “new”, “save”, "delete", “excel” 등 기본버튼 외의 추가버튼을 만드려면, ‘메뉴등록’ 탭에서 ‘추가버튼’을 눌러 추가 등록해야 함
- buttonsDtl (object)
    - 버튼 정보
        - text : 버튼 표시값
        - role : 권한
        - theme : 아이콘

- on{Name} 함수
    - ‘Name’의 버튼을 클릭하면 on{Name}의 함수가 실행됨

<br>