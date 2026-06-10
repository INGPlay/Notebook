---
date: 2024-06-11 16:33:47
created: 2024-06-04 15:03:31
categories:
- 인포마인드 / 메모 - 인포마인드
---

## 물류창고 데이터 예측 - API 스펙 (status 추가)

<br>

<br>

- 상품 불러오기 API
    - Request
        - method : GET
    - Response
        - 파라미터
            - “name” : 상품이름

```
{
    "list": [
        {
            "name": "감귤타르트-대"
        },
        {
            "name": "감귤타르트-특대"
        },
        {
            "name": "제주종합초콜릿"
        }
    ]
}
```

<br>

<br>

- 상품 예측 API
    - Request
        - method : GET
        - 파라미터
            - “startWeek” : 시작하는 주간 
            - “endWeek” : 끝나는 주간
            - “name” : 상품이름

```
{
  "startWeek" : "20240301",
  "endWeek" : "20240503",
  "name" : "감귤타르트-특대"
}
```

<br>

<br>

<br>

    - Response
        - 요청값으로 주어진 “startWeek”와 “endWeek”의 사이의 예측 데이터(startWeek <= 예측기간 <= endWeek)
        - 파라미터
            - “year” : 연도
            - “month” : 월
            - “week” : 주
            - “name” : 상품이름
            - “predQty” : 예측수량
            - “realQty” : 실제수량

<br>

        - 성공 응답 시

```
{
        "status" : "success",
        "list": [
            {
                "year": "2024",
                "month": "03",
                "week": "01",
                "name": "감귤타르트-대",
                "predQty": 291,
                "realQty": 388
            },
            {
                "year": "2024",
                "month": "03",
                "week": "02",
                "name": "감귤타르트-대",
                "predQty": 311,
                "realQty": 354
            },
            {
                "year": "2024",
                "month": "03",
                "week": "03",
                "name": "감귤타르트-대",
                "predQty": 355,
                "realQty": 491
            },
            {
                "year": "2024",
                "month": "03",
                "week": "04",
                "name": "감귤타르트-대",
                "predQty": 448,
                "realQty": 529
            },
            {
                "year": "2024",
                "month": "04",
                "week": "01",
                "name": "감귤타르트-대",
                "predQty": 299,
                "realQty": 391
            },
            {
                "year": "2024",
                "month": "04",
                "week": "02",
                "name": "감귤타르트-대",
                "predQty": 299,
                "realQty": 356
            },
            {
                "year": "2024",
                "month": "04",
                "week": "03",
                "name": "감귤타르트-대",
                "predQty": 358,
                "realQty": 499
            },
            {
                "year": "2024",
                "month": "04",
                "week": "04",
                "name": "감귤타르트-대",
                "predQty": 391,
                "realQty": 542
            },
            {
                "year": "2024",
                "month": "05",
                "week": "01",
                "name": "감귤타르트-대",
                "predQty": 317,
                "realQty": 336
            },
            {
                "year": "2024",
                "month": "05",
                "week": "02",
                "name": "감귤타르트-대",
                "predQty": 198,
                "realQty": 312
            },
            {
                "year": "2024",
                "month": "05",
                "week": "03",
                "name": "감귤타르트-대",
                "predQty": 259,
                "realQty": 335
            }
        ]
}
```

<br>

        - 에러 응답 시

```
{
        "status" : "error",
        "list": []
}
```

<br>

<br>

<br>