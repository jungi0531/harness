# 프로젝트: {프로젝트명}

## 기술 스택

| 항목 | 선택 |
|------|------|
| 런타임/프레임워크 | {예: Next.js 15 App Router / FastAPI / Spring Boot} |
| 언어 | {예: TypeScript 5 / Python 3.12 / Java 21} |
| DB/스토리지 | {예: PostgreSQL + Prisma / Redis / 없음} |
| 스타일링 | {예: Tailwind CSS v4 / styled-components / 없음} |
| 테스트 | {예: Jest + Playwright / pytest / JUnit} |
| 패키지 매니저 | {예: pnpm / npm / yarn / pip / gradle} |

## 명령어

> 아래 커맨드를 프로젝트 실제 명령어로 교체하고 이 주석은 삭제한다.

| 용도 | 커맨드 |
|------|--------|
| 개발 서버 | `{예: pnpm dev}` |
| 프로덕션 빌드 | `{예: pnpm build}` |
| 린트 | `{예: pnpm lint}` |
| 테스트 | `{예: pnpm test}` |

## 아키텍처 규칙

- CRITICAL: {절대 지켜야 할 규칙 1 (예: 모든 API 로직은 app/api/ 라우트 핸들러에서만 처리)}
- CRITICAL: {절대 지켜야 할 규칙 2 (예: 클라이언트 컴포넌트에서 직접 외부 API를 호출하지 말 것)}
- {일반 규칙 (예: 컴포넌트는 components/ 폴더에, 타입은 types/ 폴더에 분리)}

## 개발 프로세스

- CRITICAL: 새 기능 구현 시 반드시 테스트를 먼저 작성하고 (RED), 테스트가 통과하는 최소 구현을 작성할 것 (GREEN → REFACTOR)
- 커밋 메시지는 conventional commits 형식을 따를 것 (feat:, fix:, docs:, refactor:)

## 하네스 실행 규칙

- CRITICAL: 각 step을 시작하기 전에 해당 step의 `.md` 파일과 `docs/` 전체를 반드시 읽을 것
- CRITICAL: step 완료 조건은 `## Acceptance Criteria` 커맨드가 실제로 통과하는 것이다 — 단순히 코드 작성으로 완료가 아님
- CRITICAL: AC 커맨드 실패 시 즉시 원인 분석 후 수정하고 재실행한다 (최대 3회 재시도, 초과 시 `"status": "error"`)
- 사용자 개입이 필요한 상황(권한, 외부 서비스 등)이 되면 즉시 `"status": "blocked"`로 마킹하고 중단한다
