---
date: 2025-09-03 02:04:40
created: 2025-08-31 00:12:06
categories:
- 개인프로젝트 / SimpleSnippet
---

## Microsoft Store 게시하기

<br>

- Package.appxmanifest
    - ‘시각적 자산’ 탭
        - Visual Studio에서 봤을 때 사진이 표시되지 않는 게 없어야 함
        - 자산 생성기 사용해서 해도 지정 안되는게 있어서 직접 선택해야 하는게 있을 수 있음
    - ‘기능’ 탭
        - WinUI 는 기본적으로 ‘runFullTrust’ 기능을 가지고 있다더라
        - 근데 게시할 때 이거 있으면 개인정보보호정책도 써야 하고, 왜 저거 사용했는지 이유도 적어야 함
    - ‘패키징’ 탭의 ‘패키지 이름’, ‘패키지 표시 이름’, ‘게시자’, ‘게시자 표시 이름’을 맞춰져야 함
        - 패키지 이름 : Package/Identity/Name
        - 패키지 표시 이름 : App 이름
        - 게시자 : Package/Identity/Publisher
        - 게시자 표시 이름 : Package/Properties/PublisherDisplayName

<br>

- 확장프로그램의 경우 설명에 기입해야 함