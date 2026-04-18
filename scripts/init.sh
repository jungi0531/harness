#!/usr/bin/env bash
# 새 프로젝트 초기화 스크립트
# 사용법: bash scripts/init.sh "My Project Name"

set -e

PROJECT_NAME=${1:-""}

if [ -z "$PROJECT_NAME" ]; then
  echo "사용법: bash scripts/init.sh \"프로젝트명\""
  exit 1
fi

ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT"

# 원본 템플릿 레포에서 직접 실행하는 실수 방지
REMOTE=$(git remote get-url origin 2>/dev/null || true)
if echo "$REMOTE" | grep -q "harness"; then
  echo "⚠  원본 harness 레포로 보입니다."
  echo "   먼저 복사한 뒤 실행하세요:"
  echo "   cp -r harness my-new-project && cd my-new-project"
  printf "   그래도 계속 진행하시겠습니까? (y/N) "
  read -r CONFIRM
  [ "$CONFIRM" = "y" ] || exit 1
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Harness 초기화: $PROJECT_NAME"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 1. 프로젝트명 교체
sed -i '' "s/{프로젝트명}/$PROJECT_NAME/g" CLAUDE.md
sed -i '' "s/{프로젝트명}/$PROJECT_NAME/g" docs/PRD.md
echo "  ✓ CLAUDE.md, docs/PRD.md 에 프로젝트명 적용"

# 2. phases 초기화 (example 삭제)
echo '{"phases": []}' > phases/index.json
if [ -d phases/example ]; then
  rm -rf phases/example
  echo "  ✓ phases/example 삭제"
fi
echo "  ✓ phases/index.json 초기화"

# 3. git 초기화 (기존 git이 없을 때만)
if [ ! -d ".git" ]; then
  git init -q
  echo "  ✓ git 초기화"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  초기화 완료! 다음 단계를 진행하세요:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  1. CLAUDE.md"
echo "     → 기술 스택, 빌드/테스트 커맨드, CRITICAL 규칙 채우기"
echo ""
echo "  2. docs/PRD.md"
echo "     → 목표, 핵심 기능, MVP 범위 채우기"
echo ""
echo "  3. docs/ARCHITECTURE.md"
echo "     → 디렉토리 구조, 패턴, 데이터 흐름 채우기 (불필요한 예시 삭제)"
echo ""
echo "  4. docs/ADR.md"
echo "     → 주요 기술 결정 기록"
echo ""
echo "  5. docs/UI_GUIDE.md (UI 없으면 삭제)"
echo "     → 디자인 방향, 컬러, 타이포 채우기"
echo ""
echo "  6. .claude/settings.json"
echo "     → Stop hook 에 실제 빌드/린트/테스트 커맨드 설정"
echo "       예) pnpm lint && pnpm build && pnpm test"
echo "       예) ruff check . && pytest"
echo "       예) go vet ./... && go test ./..."
echo ""
echo "  7. Claude 에서 /harness 실행"
echo "     → docs/ 를 읽고 step 설계 초안 제시"
echo ""
