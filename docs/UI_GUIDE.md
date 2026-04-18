# UI 가이드

> UI/프론트엔드가 없는 프로젝트는 이 파일을 삭제한다.

## 디자인 방향

{구체적인 방향을 선택한다. "미니멀"처럼 모호한 표현은 피한다.}

예시 선택지:
- 에디토리얼 / 매거진 — 타이포그래피 주도, 여백 중심
- 네오브루탈리즘 — 두꺼운 보더, 강한 색상 대비
- 다크 럭셔리 — 어두운 배경, 절제된 골드/크림 포인트
- 스위스 / 인터내셔널 — 그리드 기반, 기하학적 타이포
- 벤토 레이아웃 — 크기 다양한 카드 그리드, 계층 중심

선택: {방향}

---

## 컬러 팔레트

```css
:root {
  /* 배경 */
  --color-bg:      {예: oklch(98% 0 0)};      /* 흰색 계열 */
  --color-surface: {예: oklch(96% 0 0)};      /* 카드 배경 */

  /* 텍스트 */
  --color-text:    {예: oklch(18% 0 0)};      /* 주 텍스트 */
  --color-muted:   {예: oklch(50% 0 0)};      /* 보조 텍스트 */

  /* 포인트 */
  --color-accent:  {예: oklch(68% 0.21 250)}; /* 브랜드 컬러 */
  --color-accent-hover: {예: oklch(60% 0.21 250)};

  /* 상태 */
  --color-error:   {예: oklch(55% 0.22 25)};
  --color-success: {예: oklch(60% 0.17 145)};
}
```

다크모드 사용 여부: {예: 없음 / 시스템 따름 / 고정 다크}

---

## 타이포그래피

```css
:root {
  --font-sans:    {예: 'Pretendard', 'Inter', sans-serif};
  --font-mono:    {예: 'JetBrains Mono', monospace};

  --text-xs:      clamp(0.75rem,  0.7rem  + 0.2vw, 0.875rem);
  --text-sm:      clamp(0.875rem, 0.82rem + 0.2vw, 1rem);
  --text-base:    clamp(1rem,     0.92rem + 0.4vw, 1.125rem);
  --text-lg:      clamp(1.125rem, 1rem    + 0.6vw, 1.375rem);
  --text-xl:      clamp(1.5rem,   1.2rem  + 1.5vw, 2.25rem);
  --text-hero:    clamp(2.5rem,   1.5rem  + 5vw,   6rem);
}
```

---

## 간격 / 레이아웃

```css
:root {
  --space-xs:      0.25rem;
  --space-sm:      0.5rem;
  --space-md:      1rem;
  --space-lg:      2rem;
  --space-xl:      4rem;
  --space-section: clamp(4rem, 3rem + 5vw, 10rem);

  --radius-sm:     4px;
  --radius-md:     8px;
  --radius-lg:     16px;
  --radius-full:   9999px;

  --max-width:     {예: 1280px};
}
```

---

## 애니메이션

```css
:root {
  --duration-fast:   150ms;
  --duration-normal: 300ms;
  --duration-slow:   500ms;
  --ease-out-expo:   cubic-bezier(0.16, 1, 0.3, 1);
}
```

- Compositor 친화적 속성만 애니메이션: `transform`, `opacity`, `clip-path`
- `width`, `height`, `margin`, `padding`은 애니메이션하지 않는다
- `prefers-reduced-motion` 반드시 지원

---

## 컴포넌트 인벤토리

MVP에 필요한 컴포넌트 목록:

| 컴포넌트 | 상태 | 비고 |
|----------|------|------|
| {예: Button} | {예: pending} | {예: primary / ghost / destructive 세 가지 variant} |
| {예: Input} | {예: pending} | |
| {예: Card} | {예: pending} | |

---

## 반응형 중단점

| 이름 | 너비 | 용도 |
|------|------|------|
| mobile | < 640px | 단일 컬럼 |
| tablet | 640px–1024px | 2컬럼 |
| desktop | > 1024px | 풀 레이아웃 |
