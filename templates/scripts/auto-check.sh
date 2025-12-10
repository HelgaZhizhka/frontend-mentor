#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m'

ERROR_COUNT=0
WARNING_COUNT=0
INTERFACE_COUNT=0
TYPE_COUNT=0
ENUM_COUNT=0
GENERIC_FUNCTION_COUNT=0
GENERIC_TYPE_COUNT=0
CLASS_COUNT=0
PRIVATE_COUNT=0
PUBLIC_COUNT=0
PROTECTED_COUNT=0
CONSOLE_COUNT=0
COMMENTED_CODE=0
TODO_COUNT=0
COMMIT_COUNT=0
CONVENTIONAL_COMMITS=0
COMMIT_PERCENTAGE=0

check() {
  local name="$1"
  local command="$2"

  echo -e "\n${BLUE}[Проверка]${NC} $name"

  if eval "$command" > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Пройдено${NC}"
    return 0
  else
    echo -e "${RED}❌ Не пройдено${NC}"
    return 1
  fi
}

echo "============================================================================"
echo "   Автоматическая проверка: Migration NewsAPI to TypeScript"
echo "============================================================================"


if [ -n "$1" ]; then
  PROJECT_DIR="$1"
  if [ ! -d "$PROJECT_DIR" ]; then
    echo -e "${RED}Ошибка: Директория не найдена: $PROJECT_DIR${NC}"
    exit 1
  fi
  echo -e "${BLUE}Проверка проекта:${NC} $PROJECT_DIR"
  cd "$PROJECT_DIR" || exit 1
else
  PROJECT_DIR=$(pwd)
  echo -e "${BLUE}Проверка проекта:${NC} $PROJECT_DIR"
fi

if [ ! -f "package.json" ] && [ ! -d "src" ]; then
  echo -e "${YELLOW}⚠️  Внимание: Не найдены package.json или src/${NC}"
  echo -e "${YELLOW}   Вы находитесь в корне проекта студента?${NC}"
  echo ""
  read -p "Продолжить проверку? (y/n): " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

if [ -f "package.json" ]; then
  PROJECT_NAME=$(grep '"name"' package.json | head -1 | sed 's/.*"name": "\(.*\)".*/\1/' | tr -d ',')
else
  PROJECT_NAME=$(basename "$PROJECT_DIR")
fi

echo -e "${MAGENTA}Проект:${NC} $PROJECT_NAME"
echo ""

echo -e "${YELLOW}════════════════════════════════════════${NC}"
echo -e "${YELLOW}  1. Проверка конфигурации${NC}"
echo -e "${YELLOW}════════════════════════════════════════${NC}"

check "tsconfig.json: strict mode включен" \
  "grep -q '\"strict\"[[:space:]]*:[[:space:]]*true' tsconfig.json"

check "tsconfig.json: noImplicitAny включен" \
  "grep -q '\"noImplicitAny\"[[:space:]]*:[[:space:]]*true' tsconfig.json"

echo -e "\n${BLUE}[Проверка]${NC} ESLint: правило no-explicit-any"
if grep -rq "no-explicit-any" eslint.config.js .eslintrc.* 2>/dev/null || \
   grep -rq "@typescript-eslint/no-explicit-any" eslint.config.js .eslintrc.* 2>/dev/null; then
  echo -e "${GREEN}✅ Пройдено${NC}"
else
  echo -e "${RED}❌ Не пройдено${NC}"
  echo -e "${YELLOW}   Подсказка: добавьте в eslint.config.js:${NC}"
  echo -e "${YELLOW}   '@typescript-eslint/no-explicit-any': 'error'${NC}"
fi

echo -e "\n${BLUE}[Проверка]${NC} Webpack: TypeScript loader настроен"
if grep -rq "ts-loader\|@babel/preset-typescript" webpack.config.* 2>/dev/null; then
  echo -e "${GREEN}✅ Пройдено${NC}"
else
  echo -e "${YELLOW}⚠️  ts-loader не найден${NC}"
  echo -e "${YELLOW}   Можно использовать babel с @babel/preset-typescript${NC}"
fi

echo -e "\n${BLUE}[Проверка]${NC} Использование 'any' в коде"

ANY_COUNT=0
ANY_LOCATIONS=()

if [ -d "src" ]; then
  while IFS= read -r line; do
    ANY_LOCATIONS+=("$line")
    ((ANY_COUNT++))
  done < <(grep -rn '\bany\b' src/ --include="*.ts" --include="*.tsx" 2>/dev/null | grep -v '//' || true)
fi

if [ "$ANY_COUNT" -eq 0 ]; then
  echo -e "${GREEN}✅ Использований 'any' не найдено${NC}"
else
  echo -e "${RED}❌ Найдено $ANY_COUNT использований 'any'${NC}"
  echo -e "${YELLOW}Locations (первые 5):${NC}"
  for i in "${!ANY_LOCATIONS[@]}"; do
    if [ "$i" -lt 5 ]; then
      echo -e "${YELLOW}   ${ANY_LOCATIONS[$i]}${NC}"
    fi
  done
  if [ "$ANY_COUNT" -gt 5 ]; then
    echo -e "${YELLOW}   ... и ещё $((ANY_COUNT - 5))${NC}"
  fi
fi

echo -e "\n${YELLOW}════════════════════════════════════════${NC}"
echo -e "${YELLOW}  2. TypeScript Features${NC}"
echo -e "${YELLOW}════════════════════════════════════════${NC}"

if [ -d "src" ]; then
  echo -e "\n${BLUE}[Анализ]${NC} TypeScript конструкции"

  INTERFACE_COUNT=$(grep -r "^interface \|^export interface " src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  TYPE_COUNT=$(grep -r "^type \|^export type " src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  ENUM_COUNT=$(grep -r "^enum \|^export enum " src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  GENERIC_FUNCTION_COUNT=$(grep -r "function.*<[A-Z]" src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  GENERIC_TYPE_COUNT=$(grep -r "^type.*<[A-Z]\|^interface.*<[A-Z]" src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  CLASS_COUNT=$(grep -r "^class \|^export class " src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')

  PRIVATE_COUNT=$(grep -r "private " src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  PUBLIC_COUNT=$(grep -r "public " src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  PROTECTED_COUNT=$(grep -r "protected " src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')

  echo -e "  ${BLUE}📦 Interfaces:${NC} ${GREEN}$INTERFACE_COUNT${NC}"
  echo -e "  ${BLUE}📦 Type aliases:${NC} ${GREEN}$TYPE_COUNT${NC}"
  echo -e "  ${BLUE}📦 Enums:${NC} ${GREEN}$ENUM_COUNT${NC}"
  echo -e "  ${BLUE}⚡ Generic functions:${NC} ${GREEN}$GENERIC_FUNCTION_COUNT${NC}"
  echo -e "  ${BLUE}⚡ Generic types:${NC} ${GREEN}$GENERIC_TYPE_COUNT${NC}"
  echo -e "  ${BLUE}🏛️  Classes:${NC} ${GREEN}$CLASS_COUNT${NC}"

  if [ "$CLASS_COUNT" -gt 0 ]; then
    echo -e "  ${BLUE}🔒 Access modifiers:${NC}"
    echo -e "     private: ${GREEN}$PRIVATE_COUNT${NC}, public: ${GREEN}$PUBLIC_COUNT${NC}, protected: ${GREEN}$PROTECTED_COUNT${NC}"
  fi

  echo ""

  TOTAL_TYPES=$((INTERFACE_COUNT + TYPE_COUNT))
  TOTAL_GENERICS=$((GENERIC_FUNCTION_COUNT + GENERIC_TYPE_COUNT))

  if [ "$TOTAL_TYPES" -ge 5 ] && [ "$TOTAL_GENERICS" -ge 2 ] && [ "$ENUM_COUNT" -ge 1 ] && [ "$CLASS_COUNT" -ge 1 ]; then
    echo -e "${GREEN}✅ TypeScript features используются хорошо${NC}"
  elif [ "$TOTAL_TYPES" -ge 3 ] && [ "$TOTAL_GENERICS" -ge 1 ]; then
    echo -e "${YELLOW}⚠️  TypeScript features используются, но можно больше${NC}"
    echo -e "${YELLOW}   Рекомендации:${NC}"
    [ "$ENUM_COUNT" -eq 0 ] && echo -e "${YELLOW}   - Добавьте enums для категорий/статусов${NC}"
    [ "$TOTAL_GENERICS" -lt 2 ] && echo -e "${YELLOW}   - Используйте больше generics для переиспользования${NC}"
    [ "$CLASS_COUNT" -eq 0 ] && echo -e "${YELLOW}   - Рассмотрите использование классов для сервисов${NC}"
  else
    echo -e "${RED}❌ Мало TypeScript features (требуется ручная проверка)${NC}"
    echo -e "${RED}   Критично мало:${NC}"
    [ "$TOTAL_TYPES" -lt 3 ] && echo -e "${RED}   - Интерфейсов/типов: $TOTAL_TYPES (нужно ≥3)${NC}"
    [ "$TOTAL_GENERICS" -lt 1 ] && echo -e "${RED}   - Generics: $TOTAL_GENERICS (нужно ≥1)${NC}"
    [ "$ENUM_COUNT" -lt 1 ] && echo -e "${RED}   - Enums: $ENUM_COUNT (нужно ≥1)${NC}"
  fi
fi

echo -e "\n${YELLOW}════════════════════════════════════════${NC}"
echo -e "${YELLOW}  3. Качество кода${NC}"
echo -e "${YELLOW}════════════════════════════════════════${NC}"

if [ -d "src" ]; then
  echo -e "\n${BLUE}[Проверка]${NC} Нет console.log в продакшн коде"
  CONSOLE_COUNT=$(grep -r "console\.log" src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$CONSOLE_COUNT" -eq 0 ]; then
    echo -e "${GREEN}✅ console.log не найден${NC}"
  else
    echo -e "${YELLOW}⚠️  Найдено $CONSOLE_COUNT использований console.log${NC}"
    echo -e "${YELLOW}   Удалите перед production${NC}"
  fi

  echo -e "\n${BLUE}[Проверка]${NC} Нет закомментированного кода"
  COMMENTED_CODE=$(grep -rE "^[[:space:]]*//.*[=\(\{]|^[[:space:]]*//.*function|^[[:space:]]*//.*const|^[[:space:]]*//.*let" src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$COMMENTED_CODE" -eq 0 ]; then
    echo -e "${GREEN}✅ Закомментированный код не найден${NC}"
  else
    echo -e "${YELLOW}⚠️  Подозрений на закомментированный код: $COMMENTED_CODE${NC}"
    echo -e "${YELLOW}   Проверьте и удалите неиспользуемый код${NC}"
  fi

  echo -e "\n${BLUE}[Проверка]${NC} TODO/FIXME комментарии"
  TODO_COUNT=$(grep -r "TODO\|FIXME" src/ --include="*.ts" --include="*.tsx" 2>/dev/null | wc -l | tr -d ' ')
  if [ "$TODO_COUNT" -eq 0 ]; then
    echo -e "${GREEN}✅ TODO/FIXME не найдены${NC}"
  else
    echo -e "${YELLOW}⚠️  Найдено $TODO_COUNT TODO/FIXME${NC}"
    echo -e "${YELLOW}   Убедитесь что все задачи выполнены${NC}"
  fi
fi

echo -e "\n${YELLOW}════════════════════════════════════════${NC}"
echo -e "${YELLOW}  4. Сборка и линтинг${NC}"
echo -e "${YELLOW}════════════════════════════════════════${NC}"

if [ ! -f "package.json" ]; then
  echo -e "${RED}❌ package.json не найден${NC}"
else
  if [ -f "pnpm-lock.yaml" ]; then
    PM="pnpm"
  elif [ -f "yarn.lock" ]; then
    PM="yarn"
  elif [ -f "package-lock.json" ]; then
    PM="npm"
  else
    PM="npm"
  fi

  echo -e "${BLUE}Package manager:${NC} $PM"

  if [ ! -d "node_modules" ]; then
    echo -e "\n${YELLOW}⚠️  node_modules не найден${NC}"
    echo -e "${BLUE}Установить зависимости? (требуется для проверки build/lint)${NC}"
    read -p "Установить? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo -e "${BLUE}[Установка]${NC} Установка зависимостей..."
      if $PM install > /dev/null 2>&1; then
        echo -e "${GREEN}✅ Зависимости установлены${NC}"
      else
        echo -e "${RED}❌ Ошибка установки зависимостей${NC}"
        echo -e "${YELLOW}Проверки build/lint пропущены${NC}"
      fi
    else
      echo -e "${YELLOW}Проверки build/lint пропущены${NC}"
    fi
  fi

  if [ -d "node_modules" ]; then
    echo -e "\n${BLUE}[Проверка]${NC} TypeScript зависимости"
    if grep -q "\"typescript\"" package.json; then
      TS_VERSION=$(grep "\"typescript\"" package.json | sed 's/.*": "\(.*\)".*/\1/' | tr -d ',')
      echo -e "${GREEN}✅ TypeScript установлен: $TS_VERSION${NC}"
    else
      echo -e "${RED}❌ TypeScript не найден в зависимостях${NC}"
    fi

    if grep -q "\"lint\"" package.json; then
      echo -e "\n${BLUE}[Линтер]${NC} Запуск ESLint..."
      if $PM run lint > /tmp/lint-output.txt 2>&1; then
        echo -e "${GREEN}✅ ESLint: проверка пройдена без ошибок${NC}"
      else
        ERROR_COUNT=$(grep -c "error" /tmp/lint-output.txt 2>/dev/null | tr -d ' \n' || echo "0")
        WARNING_COUNT=$(grep -c "warning" /tmp/lint-output.txt 2>/dev/null | tr -d ' \n' || echo "0")

        echo -e "${RED}❌ ESLint: найдены ошибки${NC}"
        echo -e "${YELLOW}   Ошибки (errors): $ERROR_COUNT${NC}"
        echo -e "${YELLOW}   Предупреждения (warnings): $WARNING_COUNT${NC}"
        echo -e "${YELLOW}   Первые несколько ошибок:${NC}"
        head -20 /tmp/lint-output.txt | grep -E "error|warning" | head -5 || true
        echo -e "${YELLOW}   Запустите '$PM run lint' для полного отчёта${NC}"
      fi
    else
      echo -e "${YELLOW}⚠️  Скрипт 'lint' не найден в package.json${NC}"
    fi

    if grep -q "\"build\"" package.json; then
      echo -e "\n${BLUE}[Сборка]${NC} Запуск build..."
      if $PM run build > /tmp/build-output.txt 2>&1; then
        echo -e "${GREEN}✅ Проект собирается без ошибок${NC}"
        if [ -d "dist" ] || [ -d "build" ]; then
          BUILD_DIR=$([ -d "dist" ] && echo "dist" || echo "build")
          BUILD_SIZE=$(du -sh "$BUILD_DIR" 2>/dev/null | cut -f1)
          echo -e "${BLUE}   Размер сборки:${NC} $BUILD_SIZE"
        fi
      else
        echo -e "${RED}❌ Ошибка при сборке проекта${NC}"
        echo -e "${YELLOW}Последние строки вывода:${NC}"
        tail -10 /tmp/build-output.txt || true
        echo -e "${YELLOW}   Запустите '$PM run build' для деталей${NC}"
      fi
    else
      echo -e "${YELLOW}⚠️  Скрипт 'build' не найден в package.json${NC}"
    fi
  fi
fi

echo -e "\n${YELLOW}════════════════════════════════════════${NC}"
echo -e "${YELLOW}  5. Git история${NC}"
echo -e "${YELLOW}════════════════════════════════════════${NC}"

if git rev-parse --git-dir >/dev/null 2>&1; then
  echo -e "\n${BLUE}[Анализ]${NC} Последние 10 коммитов:"
  git --no-pager log --oneline -10 --pretty=format:"  %C(yellow)%h%C(reset) %s" 2>/dev/null || true
  echo ""

  COMMIT_COUNT=$(git --no-pager log --oneline 2>/dev/null | wc -l | tr -d ' ')
  echo -e "\n${BLUE}Всего коммитов:${NC} $COMMIT_COUNT"

  CONVENTIONAL_COMMITS=$(git --no-pager log --oneline --pretty=format:"%s" 2>/dev/null | grep -E "^(feat|fix|docs|style|refactor|test|chore)(\(.+\))?:" | wc -l | tr -d ' ')
  if [ "$CONVENTIONAL_COMMITS" -gt 0 ]; then
    COMMIT_PERCENTAGE=$((CONVENTIONAL_COMMITS * 100 / COMMIT_COUNT))
    if [ "$COMMIT_PERCENTAGE" -ge 80 ]; then
      echo -e "${GREEN}✅ Коммитов в conventional format: $CONVENTIONAL_COMMITS ($COMMIT_PERCENTAGE%)${NC}"
    else
      echo -e "${YELLOW}⚠️  Коммитов в conventional format: $CONVENTIONAL_COMMITS ($COMMIT_PERCENTAGE%)${NC}"
      echo -e "${YELLOW}   Рекомендуется ≥80% коммитов в формате: type(scope): message${NC}"
    fi
  else
    echo -e "${RED}❌ Коммиты не следуют conventional commits format${NC}"
    echo -e "${YELLOW}   Формат: feat(scope): description${NC}"
    echo -e "${YELLOW}   Примеры: feat(types): add News interface${NC}"
    echo -e "${YELLOW}            refactor(api): migrate to TypeScript${NC}"
  fi

  echo -e "\n${BLUE}[Проверка]${NC} Лишние файлы в git"
  UNWANTED_FILES=$(git --no-pager ls-files 2>/dev/null | grep -E "node_modules/|\.env$|dist/|build/|\.log$" || true)
  if [ -z "$UNWANTED_FILES" ]; then
    echo -e "${GREEN}✅ Лишние файлы не найдены в git${NC}"
  else
    echo -e "${RED}⚠️  Найдены файлы которые НЕ должны быть в git:${NC}"
    echo "$UNWANTED_FILES" | head -5
    UNWANTED_COUNT=$(echo "$UNWANTED_FILES" | wc -l | tr -d ' ')
    if [ "$UNWANTED_COUNT" -gt 5 ]; then
      echo -e "${YELLOW}   ... и ещё $((UNWANTED_COUNT - 5)) файлов${NC}"
    fi
    echo -e "${YELLOW}   Проверьте .gitignore (секция 1.2 чеклиста)${NC}"
  fi
else
  echo -e "${YELLOW}⚠️  .git директория не найдена${NC}"
fi

echo -e "\n${YELLOW}════════════════════════════════════════${NC}"
echo -e "${YELLOW}  ИТОГОВЫЙ ОТЧЕТ${NC}"
echo -e "${YELLOW}════════════════════════════════════════${NC}"

echo -e "\n${MAGENTA}Проект:${NC} $PROJECT_NAME"
echo -e "${MAGENTA}Директория:${NC} $PROJECT_DIR"

echo -e "\n${BLUE}Конфигурация:${NC}"
echo -e "  tsconfig: strict mode - проверено выше"
echo -e "  tsconfig: noImplicitAny - проверено выше"
echo -e "  ESLint: no-explicit-any - проверено выше"
echo -e "  Webpack: TypeScript loader - проверено выше"
echo -e "  Отсутствие 'any' в коде - проверено выше"

echo -e "\n${BLUE}Статистика TypeScript:${NC}"
echo -e "  Interfaces/Types: ${GREEN}$((INTERFACE_COUNT + TYPE_COUNT))${NC}"
echo -e "  Enums: ${GREEN}${ENUM_COUNT}${NC}"
echo -e "  Generics: ${GREEN}$((GENERIC_FUNCTION_COUNT + GENERIC_TYPE_COUNT))${NC}"
echo -e "  Classes: ${GREEN}${CLASS_COUNT}${NC}"
if [ "$CLASS_COUNT" -gt 0 ]; then
  echo -e "  Access modifiers:"
  echo -e "    private: ${GREEN}$PRIVATE_COUNT${NC}, public: ${GREEN}$PUBLIC_COUNT${NC}, protected: ${GREEN}$PROTECTED_COUNT${NC}"
fi
echo -e "  Использований 'any': ${RED}${ANY_COUNT}${NC}"

echo -e "\n${BLUE}Качество кода:${NC}"
echo -e "  console.log: ${CONSOLE_COUNT}"
echo -e "  Закомментированный код: ${COMMENTED_CODE}"
echo -e "  TODO/FIXME: ${TODO_COUNT}"

if [ "$ERROR_COUNT" -gt 0 ] || [ "$WARNING_COUNT" -gt 0 ]; then
  echo -e "\n${BLUE}ESLint:${NC}"
  echo -e "  Errors: ${RED}${ERROR_COUNT}${NC}"
  echo -e "  Warnings: ${YELLOW}${WARNING_COUNT}${NC}"
fi

echo -e "\n${BLUE}Git commits:${NC}"
echo -e "  Всего: ${COMMIT_COUNT}"
if [ "$CONVENTIONAL_COMMITS" -gt 0 ]; then
  echo -e "  Conventional commits: ${GREEN}${CONVENTIONAL_COMMITS}${NC} (${COMMIT_PERCENTAGE}%)"
else
  echo -e "  Conventional commits: ${RED}0${NC}"
fi

echo -e "\n${YELLOW}Ручная проверка:${NC}"
echo -e "  ${YELLOW}•${NC} PR format и Git commits качество"
echo -e "  ${YELLOW}•${NC} TypeScript Features - осмысленность использования"
echo -e "  ${YELLOW}•${NC} Архитектура проекта"
echo -e "  ${YELLOW}•${NC} Responsive дизайн (320px-1920px)"
echo -e "  ${YELLOW}•${NC} Кастомный дизайн и UI/UX"

REPORT_FILE="auto-check-report-$(date +%Y%m%d-%H%M%S).txt"
{
  echo "Автоматическая проверка: Migration NewsAPI to TypeScript"
  echo "========================================================="
  echo "Дата: $(date)"
  echo "Проект: $PROJECT_NAME"
  echo "Директория: $PROJECT_DIR"
  echo ""
  echo "КОНФИГУРАЦИЯ"
  echo "============"
  echo "См. детали выше в консоли"
  echo ""
  echo "СТАТИСТИКА TYPESCRIPT"
  echo "===================="
  echo "Interfaces: $INTERFACE_COUNT"
  echo "Type aliases: $TYPE_COUNT"
  echo "Enums: $ENUM_COUNT"
  echo "Generic functions: $GENERIC_FUNCTION_COUNT"
  echo "Generic types: $GENERIC_TYPE_COUNT"
  echo "Classes: $CLASS_COUNT"
  echo "Access modifiers (private): $PRIVATE_COUNT"
  echo "Access modifiers (public): $PUBLIC_COUNT"
  echo "Использований 'any': $ANY_COUNT"
  echo ""
  echo "КАЧЕСТВО КОДА"
  echo "============"
  echo "console.log: $CONSOLE_COUNT"
  echo "Закомментированный код: $COMMENTED_CODE"
  echo "TODO/FIXME: $TODO_COUNT"
  echo ""
  echo "ESLINT"
  echo "======"
  if [ "$ERROR_COUNT" -gt 0 ] || [ "$WARNING_COUNT" -gt 0 ]; then
    echo "Errors: $ERROR_COUNT"
    echo "Warnings: $WARNING_COUNT"
  else
    echo "Ошибок не найдено"
  fi
  echo ""
  if [ "$ANY_COUNT" -gt 0 ]; then
    echo "LOCATIONS 'any'"
    echo "==============="
    for loc in "${ANY_LOCATIONS[@]}"; do
      echo "$loc"
    done
    echo ""
  fi
  echo "GIT COMMITS"
  echo "==========="
  echo "Всего: $COMMIT_COUNT"
  echo "Conventional: $CONVENTIONAL_COMMITS ($COMMIT_PERCENTAGE%)"
  echo ""
  echo "Последние 10 коммитов:"
  git --no-pager log --oneline -10 2>/dev/null || echo "Git history недоступна"
} > "$REPORT_FILE"

echo -e "\n${GREEN}📄 Отчет сохранен:${NC} $REPORT_FILE"

echo ""
echo "============================================================================"
echo -e "${GREEN}Проверка завершена!${NC}"
echo "============================================================================"
