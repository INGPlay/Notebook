---
date: 2024-12-30 19:46:48
created: 2024-12-17 15:24:56
categories:
- 개인 / 글
---

## SpringPromptBuilder - 프로젝트 회고

<br>

## 1\. 개요

### 1-1. 목적

- 프롬프트, 모델 세팅을 등록하고, 이전에 등록된 세팅을 가져온다

<br>

### 1-2. 개략도

![](attachments/image%2024.png)<br>

<br>

![](attachments/image%202%207.png)<br>

<br>

![](attachments/image%203%206.png)<br>

<br>

![](attachments/image%204%205.png)<br>

<br>

### 1-3. 기술

- 사용된 기술은 다음과 같다.
- Backend
    - Java 21
    - Spring Boot 3
    - Spring MVC
    - Spring AI (AI 벤더 연결)
    - Spring Data JPA, QueryDSL (영속성)
    - Spring Security (OAuth 인증)

<br>

- 데이터베이스
    - MariaDB

<br>

- 권한
    - Keycloak

<br>

- 이미지 서버
    - ImageKit

<br>

- 캐싱
    - Redis

<br>

- 빌드 도구
    - Gradle

<br>

- 템플릿 엔진
    - Thymeleaf

<br>

- Frontend
    - Javascript (Vanilla)
    - HTMX (AJAX)
    - Webpack

<br>

- UI
    - AdminKit ([Free Bootstrap 5 Admin Template - AdminKit](https://adminkit.io/), Bootstrap 5 기반)
    - Highlight.js

<br>

- 버전관리
    - Git
    - Github

<br>

- CI/CD
    - Docker
    - Github Actions (서버 배포)

<br>

- 스캐폴딩
    - Bootify ([Rapid Spring Boot Prototypes | Bootify.io](https://bootify.io/))

<br>

- SaaS
    - Oracle Cloud (무료 서버)

<br>

## 2\. 생각

### 2-1. 기술선택

- Spring 관련
    - Spring은 서버올라가는 속도가 느리고, 핫스왑이 제한적이라 혼자 개발 시 생산성이 떨어지는 부분이 확실히 있는 것 같다.
    - 이 점에서 다음에 혼자 프로젝트를 계획한다면 Next.js 나 Django 를 사용해보지 않을까 싶다.

<br>

 UI 관련해서 아쉬웠던 점이 좀 많다. 프로젝트 특성상 싱글페이지에서 여러 상호작용할 거리가 많았는데, 그거를 HTMX와 Vanilla JS로 처리하다보니까 어려웠던 점이 많았던 것 같다.

<br>

- HTMX 관련
    - HTMX를 사용해서 갱신 시, 등록해놨었던 이벤트가 사라져서 새로 등록해줘야 하는 경우가 생긴다.
    - 이렇게 처리하긴 했는데, 뭉텅이로 처리한 거라 좋아보이지 않음

```javascript
window.addEventListener('DOMContentLoaded', function() {
    process()

    // HTMX 요청 후에 공통 후처리
    document.addEventListener('htmx:afterRequest', (evt) => {
        process()
    })

    function process() {
        // .. 갱신
    }
});
```

<br>

    - HTMX 요청 후에 여러 요소를 갱신해야하는 경우
        - HxUtils.addTrigger()는 HX-Trigger 헤더에 값을 추가하는 커스텀 유틸 함수이다.

\*Controller

```java
    @HxRequest
    @PutMapping("/fragment/chat-room/{id}/bookmark/{bookmarkYn}")
    public Mono<String> bookmark(@PathVariable("id") Long chatRoomId,
                                  @PathVariable("bookmarkYn") BookmarkYn bookmarkYn) {
        chatHtmxFacade.updateBookmark(chatRoomId, bookmarkYn);

        HxUtils.addHxTrigger("renew-chat-record");
        HxUtils.addHxTrigger("renew-chat-bookmark");

        return Mono.just("empty");
    }
```

<br>

\*HTML

```xml
            <div id="chat-bookmark"
                 th:hx-get="@{/chat/fragment/chat-side(bookmarkYn=Y)}" hx-trigger="renew-chat-bookmark from:body" hx-target="#chat-bookmark" hx-swap="innerHTML">
                ...
            </div>

            <div id="chat-record"
                 th:hx-get="@{/chat/fragment/chat-side(bookmarkYn=N)}" hx-trigger="renew-chat-record from:body" hx-target="#chat-record" hx-swap="innerHTML">
                ...
            </div>
```

<br>

- 스캐폴딩 관련
    - 스캐폴딩에 Bootify를 사용하였다. 훌륭한 프로그램이었으나, 잘못된 사용을 한 점이 있는 것 같다.

<br>

- 영속성 계층 관련 (Spring Data JPA, QueryDSL)
    - Spring Data JPA의 기능을 잘 활용할 걸 그랬다.
    - QueryDSL이 필요하지 않았었음에도 사용한 감이 있다.

<br>

- 챗 스트리밍 관련
    - 프론트에서 하기 어려워서, 서버에서 마크다운 처리했음...
    - 버퍼 처리 함

<br>

### 2-2. 서버 구성

- Keycloak 관련
    - Spring과 통합이 잘된다. 이거 하나 올려놓으면 로그인, 계정, 권한 등과 관련해서 생각할 게 줄어든다.

<br>

- 클라우드 관련
    - 서버를 나눌 이유가 없다면 나눌 필요가 없다. 어찌보면 당연하긴 한데...

<br>

### 2-3. 의욕

- 혼자 프로젝트를 진행하는데 가장 중요한 점이다. 하기 싫다면 그게 끝이다.
- 프로젝트에 너무 매몰되지 않는게 좋은 것 같다.

<br>

## 3\. 결론

다음 프로젝트는 위의 사항을 반여하여 프로젝트를 진행해야겠다.

<br>

<br>