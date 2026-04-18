# 아키텍처

## 디렉토리 구조

아래 중 프로젝트 유형에 맞는 구조를 선택하고 나머지는 삭제한다.

### Web (Next.js App Router)

```
src/
├── app/               # 페이지 + API 라우트
│   └── api/           # API 핸들러만 위치
├── components/        # UI 컴포넌트
├── types/             # TypeScript 타입 정의
├── lib/               # 유틸리티 + 헬퍼
└── services/          # 외부 API 래퍼
```

### API 서버 (FastAPI / Express / Spring Boot)

```
src/
├── routes/            # 라우터 / 컨트롤러
├── services/          # 비즈니스 로직
├── repositories/      # DB 접근 계층
├── models/            # 도메인 모델 + 스키마
├── middleware/        # 인증, 로깅, 에러 처리
└── utils/             # 공통 유틸
```

### CLI / 스크립트

```
src/
├── commands/          # CLI 커맨드 핸들러
├── core/              # 핵심 비즈니스 로직
├── adapters/          # 외부 서비스 연동
└── utils/             # 공통 유틸
```

---

## 패턴

{사용하는 핵심 패턴을 적는다.}

예시:
- Server Component를 기본, 인터랙션이 필요한 곳만 Client Component
- Repository 패턴으로 DB 접근 추상화
- 서비스 계층에서 비즈니스 로직 처리, 라우터는 요청/응답 변환만

---

## 데이터 흐름

```
{데이터가 어떻게 흐르는지 한 줄로 표현}

예시:
사용자 입력 → Client Component → API Route → Service → Repository → DB
                                                              ↓
                                              응답 → UI 업데이트
```

---

## 상태 관리

{상태 관리 전략을 적는다.}

예시:
- 서버 상태: Server Components + TanStack Query (캐싱/재검증)
- 클라이언트 상태: useState / Zustand (전역 필요 시)
- URL 상태: searchParams (필터, 페이지네이션, 탭)
- 폼 상태: React Hook Form

---

## 외부 의존성

{프로젝트에서 사용하는 외부 서비스/API를 나열한다.}

| 서비스 | 용도 | 설정 위치 |
|--------|------|-----------|
| {예: OpenAI API} | {예: 텍스트 생성} | `.env` |
| {예: Supabase} | {예: DB + 인증} | `.env` |
