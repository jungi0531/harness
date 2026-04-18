# Harness — AI 자율 실행 Step 프레임워크

프로젝트를 독립된 step으로 분해하고, 각 step을 Claude가 자율 실행하는 템플릿.

## 핵심 개념

```
phases/
├── index.json            ← 전체 phase 현황 (execute.py가 자동 관리)
└── 0-mvp/
    ├── index.json        ← step 목록 + 상태
    ├── step0.md          ← Claude에게 전달하는 지시문
    └── step1.md
```

`execute.py`가 각 step을 Claude에 실행 → 실패 시 최대 3회 재시도 → git 커밋 자동화.

---

## 새 프로젝트 시작

### 1. 이 레포 복사 후 초기화

```bash
cp -r harness my-new-project
cd my-new-project
bash scripts/init.sh "My Project Name"
```

`init.sh`가 자동으로 처리:
- CLAUDE.md, docs/PRD.md 에 프로젝트명 치환
- `phases/example` 삭제
- `phases/index.json` 초기화

### 2. 설정 파일 채우기

| 파일 | 내용 | 필수 |
|------|------|:----:|
| `CLAUDE.md` | 기술 스택, 빌드/테스트 커맨드, CRITICAL 규칙 | ✓ |
| `docs/PRD.md` | 목표, 핵심 기능, MVP 범위 | ✓ |
| `docs/ARCHITECTURE.md` | 디렉토리 구조, 패턴, 데이터 흐름 | ✓ |
| `docs/ADR.md` | 주요 기술 결정 기록 | ✓ |
| `docs/UI_GUIDE.md` | 디자인 방향, 컬러, 타이포 | UI만 |

> `docs/ARCHITECTURE.md`는 프로젝트 유형에 맞는 구조 예시 하나만 남기고 나머지는 삭제.
> UI가 없는 프로젝트는 `docs/UI_GUIDE.md`를 삭제.

### 3. Stop Hook 설정

`.claude/settings.json`의 Stop hook 명령어를 프로젝트 빌드 명령어로 교체:

```json
"command": "pnpm lint 2>&1 && pnpm build 2>&1 && pnpm test 2>&1 || true"
```

스택별 예시:
- Node.js: `pnpm lint && pnpm build && pnpm test`
- Python: `ruff check . && pytest`
- Go: `go vet ./... && go test ./...`

### 4. Claude에서 `/harness` 실행

> `/harness`는 Claude Code 슬래시 커맨드다. `.claude/commands/harness.md`에 정의되어 있으며,
> Claude Code CLI(터미널) 또는 IDE 확장에서 대화 중 `/harness`를 입력하면 실행된다.

Claude가 `docs/`를 읽고 step 설계 초안을 제시한다. 검토·수정 후 승인하면 `phases/` 파일들을 자동 생성한다.

### 5. 실행

```bash
python3 scripts/execute.py 0-mvp          # phase 순차 실행
python3 scripts/execute.py 0-mvp --push   # 실행 후 origin push
```

### 여러 phase를 이어서 실행할 때

`/harness`로 phase를 추가하면 `phases/index.json`의 `phases` 배열에 항목이 추가된다.
각 phase는 독립적으로 실행하며, 전 단계가 완료된 뒤 다음 phase를 실행한다.

```bash
python3 scripts/execute.py 0-mvp       # 1단계 완료 후
python3 scripts/execute.py 1-polish    # 2단계 실행
```

---

## 에러 복구

**error 상태**: `phases/{task}/index.json`에서 해당 step의 `status`를 `"pending"`으로, `error_message`를 삭제한 뒤 재실행

**blocked 상태**: `blocked_reason`의 사유를 해결한 뒤 `status`를 `"pending"`으로, `blocked_reason`을 삭제한 뒤 재실행

---

## 전체 파일 구조

```
harness/
├── CLAUDE.md                    ← 프로젝트 규칙 (매 step 프롬프트에 자동 주입)
├── docs/
│   ├── PRD.md                   ← 제품 요구사항
│   ├── ARCHITECTURE.md          ← 아키텍처 설계
│   ├── ADR.md                   ← 기술 결정 기록
│   └── UI_GUIDE.md              ← UI/디자인 가이드 (선택)
├── phases/
│   ├── index.json               ← 전체 phase 현황
│   ├── example/                 ← step 작성법 예시 (init.sh가 삭제)
│   └── {your-phase}/
├── scripts/
│   ├── init.sh                  ← 새 프로젝트 초기화
│   ├── execute.py               ← 핵심 실행기
│   └── test_execute.py          ← 실행기 테스트
└── .claude/
    ├── settings.json            ← hooks 설정 (Stop hook 직접 수정 필요)
    └── commands/
        ├── harness.md           ← /harness 커맨드 (step 설계 워크플로우)
        └── review.md            ← /review 커맨드 (코드 리뷰 체크리스트)
```

---

## execute.py 동작 요약

1. `feat-{phase}` 브랜치 생성/체크아웃
2. `CLAUDE.md` + `docs/*.md`를 매 step 프롬프트에 주입 (가드레일)
3. 완료된 step의 `summary`를 다음 step에 누적 전달 (컨텍스트 축적)
4. 실패 시 최대 3회 재시도 (이전 에러 메시지 피드백)
5. step 완료마다 2단계 커밋: `feat(...)` (코드) + `chore(...)` (메타데이터)
6. 전체 완료 후 `--push` 옵션 있으면 origin push
