---
type: Note
---
# Annual-Report

- NotebookLM 자동화 기반 사항
  - notebooklm-py 설치 및 인증

```python
pip install notebooklm-py[browser]

## 기본 크로뮴
notebooklm login

## 엣지
notebooklm login --browser msedge
```

- PowerShell

```batch
[Convert]::ToBase64String([IO.File]::ReadAllBytes("$env:USERPROFILE\.notebooklm\profiles\default\storage_state.json")) | Set-Clipboard
```

- 저장소 Secret에 'NOTEBOOKLM_STORAGE_B64에 붙여넣기
