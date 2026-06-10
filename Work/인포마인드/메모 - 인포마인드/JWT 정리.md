---
date: 2026-03-18 15:13:38
created: 2026-03-17 10:18:05
categories:
- 인포마인드 / 메모 - 인포마인드
---

## JWT 정리

<br>

- 설명

[다중 서버 환경에서 세션을 관리하는 방법](https://velog.io/@hyeminn/%EB%8B%A4%EC%A4%91-%EC%84%9C%EB%B2%84-%ED%99%98%EA%B2%BD%EC%97%90%EC%84%9C-%EC%84%B8%EC%85%98%EC%9D%84-%EA%B4%80%EB%A6%AC%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95)  

<br>

<br>

## 1) JWT의 구조 및 구성 요소

JWT는 Base64Url로 인코딩 된 세 부분(Header, Payload, Signature)이 마침표(.)로 구분되어 결합된 형태로 구성된다.

![](https://image.ahnlab.com/atip/content/image/20251216/0Od9ZccS6sXhJ5sYW6xSu1TpnUVgt708kiOpxlcx.png)

**\[그림 1\] JWT 구조**

**1\. Header (헤더) : 메타 정보**

헤더는 토큰의 메타 정보를 담고 있는 JSON 객체를 Base64Url로 인코딩한 부분이다. 필수적으로 typ (Type, 일반적으로 JWT) 및 alg (Algorithm, 서명에 사용된 암호화 알고리즘, 예: HS256, RS256) 클레임을 포함한다.

```
{
  "alg": "HS256",  // 서명 알고리즘
  "typ": "JWT"     // 토큰 타입
}
```

**2\. Payload (페이로드) : 클레임(Claim)**

페이로드에는 전송하고자 하는 인증 정보, 권한 정보, 기타 속성 정보가 JSON 객체 형태로 포함되며 이를 클레임(Claim)이라고 부른다. 페이로드 역시 헤더와 마찬가지로 Base64Url로 인코딩된다.

- **클레임의 종류**클레임은 역할에 따라 Registered (표준 정의), Public (공개), Private (사설) 세 종류로 나뉜다. Registered Claims에는 토큰의 만료 시점(exp), 발급 시점(iat), 발급자(iss), 수신자(aud) 등 토큰의 유효성 검증에 활용되는 표준 필드를 포함한다.
- **보안 유의점**헤더와 페이로드는 암호화가 아닌 단순 인코딩이므로, 페이로드를 확보하면 손쉽게 디코딩하여 내용 파악이 가능하다. 따라서 페이로드에는 이메일, 결제 정보 등 민감한 개인 식별 정보(PII)를 포함해서는 안 된다.

```
{
  "sub": "user123",           // 사용자 ID
  "name": "John Doe",         // 사용자 이름
  "role": "admin",            // 권한
  "iat": 1516239022,          // 발급 시각
  "exp": 1516242622           // 만료 시각
}
```

**3\. Signature (서명) : 무결성 보장**

서명은 토큰의 무결성(Integrity) 및 신뢰성(Authenticity)을 보장하는 핵심 요소다. 서명은 인코딩된 Header와 Payload, 그리고 서버가 보관하는 Secret Key(HS256) 또는 Private Key(RS256)를 결합해 지정된 알고리즘에 따른 암호학적 서명 연산으로 계산된다. 서버는 서명을 재계산하여 수신된 서명과 일치하는지 확인하며, 이를 통해 토큰의 위변조 여부를 판단한다. 비밀 서명 키를 모르는 공격자는 유효한 서명을 생성할 수 없다.

```
HMACSHA256(
  base64UrlEncode(header) + "." + base64UrlEncode(payload),
  SECRET_KEY
)
```

## 2) 세션 기반 인증 방식과 JWT 인증 방식의 비교

세션 기반 인증 방식과 JWT 인증 방식의 차이는 \[그림 2\]의 도식 비교를 통해 확인할 수 있다.

![](https://image.ahnlab.com/atip/content/image/20251216/Sx4OAMeRRRHCUQhRL5Kl6AwvVKXjX66SvUPZknQq.png)

**\[그림 2\] 세션 기반 인증 방식과 JWT 인증 방식 과정 비교**

<br>

[JWT 기반 인증의 그림자: 편리함 뒤에 숨은 치명적 위협 - ASEC](https://asec.ahnlab.com/ko/91594/)  

<br>

- JWT
    - 인증을 통과한 사용자에게 식별값을 던져줌
        - 사용자 정보, 권한 등등, Session 처럼 필요한 값을 담아 둘 수 있음
    - 인증이 필요할 때마다 Header에 담아 보내면 됨
        - 서버에서 던져준 식별값을 사용할 수 있다

<br>

- Refresh Token
    - JWT 만료기간을 무한정 늘리거나 하면 토큰 탈취 시 보안 문제 발생
    - 그렇다고 만료시간을 짧게하면 사용자 편의가 저해된다
        - → JWT 토큰을 갱신할 수 있는 토큰의 필요성

<br>

    - 사용자 로그인 상태를 서버에서 관리할 수 있어야 함
        - DB에 저장된 해당 Refresh Token을 삭제하면 JWT 만료기한과 동시에 로그인 프로세스를 처음부터 진행해야 한다

<br>

    - Refresh Token 탈취
        - JWT 갱신 시 Refresh Token도 새로 갱신한다

<br>

<br>

- Server(예시)
    - /login - JWT, Refresh을 발급한다
    - /refresh - JWT와 Refresh를 동시 발급한다
    - /logout - Refresh Token 삭제

<br>

- Front (WEB)
    - JWT와 Refresh Token을 어딘가 잘 보관한다
        - HttpOnly, Secure 쿠키에 보관 → Refresh Token은 무조건
        - 로컬 변수(메모리)에 보관 → SPA를 사용하는 경우(페이지 이동 시에도 메모리가 유지되는 경우)
        - LocalStorage, SessionStorage에 보관 → XSS 취약

<br>

- 순서도
    - JWT

![](https://blog.kakaocdn.net/dna/KaadU/btsnOty1RYg/AAAAAAAAAAAAAAAAAAAAAEid8zUs-dAwrOWj837sdqXLwshCrFUF4fsrYjtxJc7v/img.png?credential=yqXZFxpELC7KVnFOS48ylbz2pIh7yKj8&expires=1774969199&allow_ip=&allow_referer=&signature=Q4Jy6LOXvXmW3PPX24ia9Vyeh8E%3D)

    - JWT + Refresh Token

![](https://blog.kakaocdn.net/dna/cn5Zuw/btsnZIavI7E/AAAAAAAAAAAAAAAAAAAAANd02oNZSmSNQjk_WW6BHLgDxzxgVAJL8qlekC_XcLd7/img.png?credential=yqXZFxpELC7KVnFOS48ylbz2pIh7yKj8&expires=1774969199&allow_ip=&allow_referer=&signature=869TX0EmQb%2BVkuvmw2G8lVy27G4%3D)

[\[JWT\] Access Token의 한계와 Refresh Token의 필요성](https://colabear754.tistory.com/179)  

<br>

<br>

- 구현
    - Spring Boot
        - Spring Security, Jwt Parser
    - Next.js

<br>