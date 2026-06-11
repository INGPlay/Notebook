---
date: 2025-12-29 18:11:18
created: 2025-12-29 18:10:27
categories:
- 개인프로젝트 / SimpleSnippet
---

## 오류 : 해결할 수 없는 "Microsoft.Windows.SDK.NET"의 다른 버전 간 충돌이 발견되었습니다.

<br>

- NuGet 업데이트 이후 발생

<br>

## 해결 방법 1: WindowsSdkPackageVersion 설정 (권장)

프로젝트 파일(.csproj)에 다음 속성을 추가하여 최신 SDK 버전을 강제 지정합니다:

```
<PropertyGroup>
  <WindowsSdkPackageVersion>10.0.26100.81</WindowsSdkPackageVersion>
</PropertyGroup>
```

<br>

<br>

<br>