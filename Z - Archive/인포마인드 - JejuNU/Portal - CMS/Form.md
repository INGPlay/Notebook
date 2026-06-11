---
date: 2024-10-18 10:45:48
created: 2024-10-18 10:42:38
categories:
- 인포마인드 - JejuNU / Portal - 관리자
---

## Form

<br>

- 값을 입력받는 Form 입력 시

```
<form action="${URI}" method="post" target="formReceiver">
  <!-- ... -->
</form>
```

<br>

- OK.htm
    - target이 들어간 form의 리다이렉트에는 parent가 들어간다

```
parent.location.replace('${URI}')
```

<br>