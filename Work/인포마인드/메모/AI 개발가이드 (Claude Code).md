---
date: 2026-06-09 17:19:55
created: 2026-06-09 16:49:44
categories:
- 인포마인드 / 메모 - 인포마인드
---

## AI 개발가이드 (Claude Code)

<br>

## Private

- 스크립트 언어 (설치해두는 게 좋음, 없으면 삽질할 수 있음)
    - Python (3.13 추천)
    - Node.js (최신 LTS 추천)

**<br>
**

- **.claude/settings.json**

```java
{
  "extraKnownMarketplaces": {
    "claude-plugins-official": {
      "source": {
        "source": "github",
        "repo": "anthropics/claude-plugins-official"
      }
    }
  },
  "enabledPlugins": {
    "playwright@claude-plugins-official": true,
    "context7@claude-plugins-official": true,
    "claude-md-management@claude-plugins-official": true,
    "commit-commands@claude-plugins-official": true,
    "serena@claude-plugins-official": true,
    "feature-dev@claude-plugins-official": true,
    "security-guidance@claude-plugins-official": true
  }
}

```

<br>

- 세션 프로세스
    - 세션 시작 : /feature-dev:feature-dev
    - 세션 내용 반영 : /claude-md-management:revise-claude-md
    - 세션 종료 : /commit-commands:commit

<br>

- AI 툴킷 (AI가 사용할 도구)
    - context7 - 최신 및 버전별 개발지식 가져오기
    - serena - LSP, AI 탐색 개선 및 토큰 절약
    - security-guidance - 보안검사 훅 추가 
    - playwright - 웹페이지 분석 및 탐색, 테스트, 디버깅 등

<br>

- 유지보수
    - md 개선 : /claude-md-management:claude-md-improver

<br>

- Routine
    - 코드 리뷰 지침

```
당신은 잠재 버그를 정기적으로 감사하는 리뷰어다. CLAUDE.md 의 컨벤션을
기준으로 위반·결함만 보고한다. 스타일 취향·리팩토링 제안은 제외.

## 스캔 범위
- 최근 7일 내 변경 파일 우선 (git log --since="7 days ago" --name-only)

## 리포트 형식
발견한 이슈만, 심각도 순으로 출력. 없으면 "이슈 없음" 한 줄.

### 🔴 Critical (보안/권한/데이터 손실)
- [파일:라인] 요약 — 왜 문제인지 1줄

### 🟡 High (런타임 오류 가능성)
- ...

### 🟢 Medium (규약 위반, 유지보수성)
- ...

## 금지 사항
- 코드 수정 금지 (Edit/Write 사용 금지)
- 추측성 이슈 금지. 파일·라인으로 근거 제시 못하면 제외
- "리팩토링 제안" 금지. 버그/규약 위반만
- 이미 고쳐진 항목 중복 보고 금지 (git log로 확인)

```

<br>

    - DDL 동기화 지침

```
DDL과 일치하지 않는 프로젝트 내의 Domain을 찾아서 테이블로 정리해줘
- 가장 최근 DDL만 검토, 그 외 찾아보지 말 것
- NOT NULL 같은 거에 검증이 되는지 봐줘
- 파일을 작성하거나 수정 금지

```

<br>

    - 주간보고 지침

```
# 할 일
- 현재 루트의 각 디렉토리 git에서 KST기준 지난 주 금요일부터 오늘까지 내가 커밋한 내용 정리

## Context
- 주간보고 : 지난 일주일간 한 일을 정리하기 위한 목적

## Format 
- Repository이름이 들어갈 필요가 없다
- 코드 창에 반환한다.
- 숫자 앞에 스페이스바 2칸, - 앞에 스페이스바 4칸
- 결과적으로 다음 예시 양식에 따른다
```txt
  1. 행동 1
    - 세부 1
    - 세부 2
  2. 행동 2
    - 세부 1
```

```

<br>

<br>

## Project (CMS, PORTAL)

- **.claude/settings.json**

```
{
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "MAIN_ROOT=$(git worktree list | head -1 | awk '{print $1}') && $MAIN_ROOT/node_modules/.bin/tsc --noEmit --skipLibCheck 1>&2 || exit 2",
            "timeout": 180,
            "statusMessage": "TypeScript 타입 검사 중..."
          },
          {
            "type": "command",
            "command": "MAIN_ROOT=$(git worktree list | head -1 | awk '{print $1}') && $MAIN_ROOT/node_modules/.bin/eslint 1>&2 || exit 2",
            "timeout": 180,
            "statusMessage": "ESLint 검사 중..."
          }
        ]
      }
    ]
  }
}

```

<br>

- TypeScript 검사 : 프로젝트에 TypeScript 형식에 어긋나는 곳이 있는지 검사 
    - worktree 대응하기 위해 command가 위와 같음
- ESLint 검사 : 프로젝트에 위험한 패턴이 있는지 정적 검사
    - worktree 대응하기 위해 command가 위와 같음