# Код-ревью и практики чистого кода

Практические руководства по написанию качественного кода, код-ревью и лучших практик разработки.

## 📚 Материалы

### [Часть 1: Основы чистого кода](Clean-Code-Fundamental-Part1.md)

Основные принципы написания чистого, читаемого и поддерживаемого кода.

#### Разделы:
- [**Зачем нужен чистый код?**](Clean-Code-Fundamental-Part1.md#зачем-нужен-чистый-код)
- [**1. Именование (Naming Conventions)**](Clean-Code-Fundamental-Part1.md#1-именование-naming-conventions)
  - [1.1 Общие принципы](Clean-Code-Fundamental-Part1.md#11-общие-принципы)
  - [1.2 Переменные](Clean-Code-Fundamental-Part1.md#12-переменные)
  - [1.3 Функции](Clean-Code-Fundamental-Part1.md#13-функции)
  - [1.4 Классы и компоненты](Clean-Code-Fundamental-Part1.md#14-классы-и-компоненты)
  - [1.5 Boolean переменные](Clean-Code-Fundamental-Part1.md#15-boolean-переменные)
  - [1.6 Анти-паттерны именования](Clean-Code-Fundamental-Part1.md#16-анти-паттерны-именования)
- [**2. Функции и методы**](Clean-Code-Fundamental-Part1.md#2-функции-и-методы)
  - [2.1 Размер функции](Clean-Code-Fundamental-Part1.md#21-размер-функции)
  - [2.2 Параметры функции](Clean-Code-Fundamental-Part1.md#22-параметры-функции)
  - [2.3 Побочные эффекты (Side Effects)](Clean-Code-Fundamental-Part1.md#23-побочные-эффекты-side-effects)
  - [2.4 Single Responsibility для функций](Clean-Code-Fundamental-Part1.md#24-single-responsibility-для-функций)
  - [2.5 Возврат значений](Clean-Code-Fundamental-Part1.md#25-возврат-значений)
  - [2.6 Стрелочные функции vs обычные](Clean-Code-Fundamental-Part1.md#26-стрелочные-функции-vs-обычные)
- [**3. Комментарии и документация**](Clean-Code-Fundamental-Part1.md#3-комментарии-и-документация)
  - [3.1 Когда НЕ нужны комментарии](Clean-Code-Fundamental-Part1.md#31-когда-не-нужны-комментарии)
  - [3.2 Когда комментарии полезны](Clean-Code-Fundamental-Part1.md#32-когда-комментарии-полезны)
  - [3.3 JSDoc](Clean-Code-Fundamental-Part1.md#33-jsdoc)
  - [3.4 TODO/FIXME](Clean-Code-Fundamental-Part1.md#34-todofixme)
  - [3.5 Комментарии "почему", а не "что"](Clean-Code-Fundamental-Part1.md#35-комментарии-почему-а-не-что)
- [**4. Обработка ошибок**](Clean-Code-Fundamental-Part1.md#4-обработка-ошибок)
  - [4.1 Try-Catch правила](Clean-Code-Fundamental-Part1.md#41-try-catch-правила)
  - [4.2 Fail Fast принцип](Clean-Code-Fundamental-Part1.md#42-fail-fast-принцип)
  - [4.3 Defensive Programming](Clean-Code-Fundamental-Part1.md#43-defensive-programming)
- [**5. Code Smells и рефакторинг**](Clean-Code-Fundamental-Part1.md#5-code-smells-и-рефакторинг)
  - [5.1 Duplicated Code (Дублирование)](Clean-Code-Fundamental-Part1.md#51-duplicated-code-дублирование)
  - [5.2 Long Method (Длинная функция)](Clean-Code-Fundamental-Part1.md#52-long-method-длинная-функция)
  - [5.3 Large Class (Большой класс)](Clean-Code-Fundamental-Part1.md#53-large-class-большой-класс)
  - [5.4 Long Parameter List](Clean-Code-Fundamental-Part1.md#54-long-parameter-list)
  - [5.5 Magic Numbers и Magic Strings](Clean-Code-Fundamental-Part1.md#55-magic-numbers-и-magic-strings)
  - [5.6 Dead Code (Мёртвый код)](Clean-Code-Fundamental-Part1.md#56-dead-code-мёртвый-код)
  - [5.7 Deep Nesting (Глубокая вложенность)](Clean-Code-Fundamental-Part1.md#57-deep-nesting-глубокая-вложенность)
  - [5.8 Primitive Obsession](Clean-Code-Fundamental-Part1.md#58-primitive-obsession)
  - [5.9 Switch Statements](Clean-Code-Fundamental-Part1.md#59-switch-statements)
  - [5.10 Shotgun Surgery](Clean-Code-Fundamental-Part1.md#510-shotgun-surgery)
- [**6. Организация кода**](Clean-Code-Fundamental-Part1.md#6-организация-кода)
  - [6.1 Форматирование](Clean-Code-Fundamental-Part1.md#61-форматирование)
  - [6.2 Порядок кода](Clean-Code-Fundamental-Part1.md#62-порядок-кода)
  - [6.3 Порядок импортов](Clean-Code-Fundamental-Part1.md#63-порядок-импортов)
- [**7. Работа с данными**](Clean-Code-Fundamental-Part1.md#7-работа-с-данными)
  - [7.1 Immutability (Неизменяемость)](Clean-Code-Fundamental-Part1.md#71-immutability-неизменяемость)
  - [7.2 Работа с массивами](Clean-Code-Fundamental-Part1.md#72-работа-с-массивами)
  - [7.3 Работа с объектами](Clean-Code-Fundamental-Part1.md#73-работа-с-объектами)
  - [7.4 Null и Undefined](Clean-Code-Fundamental-Part1.md#74-null-и-undefined)
- [**8. Асинхронный код**](Clean-Code-Fundamental-Part1.md#8-асинхронный-код)
  - [8.1 Promises](Clean-Code-Fundamental-Part1.md#81-promises)
  - [8.2 Async/Await](Clean-Code-Fundamental-Part1.md#82-async-await)
  - [8.3 Анти-паттерны](Clean-Code-Fundamental-Part1.md#83-анти-паттерны)
- [**9. Производительность**](Clean-Code-Fundamental-Part1.md#9-производительность)
  - [9.1 Преждевременная оптимизация](Clean-Code-Fundamental-Part1.md#91-преждевременная-оптимизация)
  - [9.2 Когда оптимизировать](Clean-Code-Fundamental-Part1.md#92-когда-оптимизировать)
  - [9.3 Простые оптимизации](Clean-Code-Fundamental-Part1.md#93-простые-оптимизации)
- [**10. Тестируемость кода**](Clean-Code-Fundamental-Part1.md#10-тестируемость-кода)
  - [10.1 Что делает код тестируемым](Clean-Code-Fundamental-Part1.md#101-что-делает-код-тестируемым)
  - [10.2 Признаки нетестируемого кода](Clean-Code-Fundamental-Part1.md#102-признаки-нетестируемого-кода)
  - [10.3 Рефакторинг для тестов](Clean-Code-Fundamental-Part1.md#103-рефакторинг-для-тестов)
- [**11. Дополнительные практики**](Clean-Code-Fundamental-Part1.md#11-дополнительные-практики)
  - [11.1 Избегать глобальных переменных](Clean-Code-Fundamental-Part1.md#111-избегать-глобальных-переменных)
  - [11.2 Избегать мутации параметров](Clean-Code-Fundamental-Part1.md#112-избегать-мутации-параметров)
  - [11.3 Стрелочные функции для методов](Clean-Code-Fundamental-Part1.md#113-стрелочные-функции-для-методов)
  - [11.4 Предпочитать объекты switch-case](Clean-Code-Fundamental-Part1.md#114-предпочитать-объекты-switch-case)
  - [11.5 Использовать const по умолчанию](Clean-Code-Fundamental-Part1.md#115-использовать-const-по-умолчанию)
  - [11.6 Осторожно с setTimeout и setInterval](Clean-Code-Fundamental-Part1.md#116-осторожно-с-settimeout-и-setinterval)

### [Часть 2: Рефакторинг и организация кода](Clean-Code-Fundamental-Part2.md)

Техники рефакторинга, code smells и лучшая организация кода.

#### Разделы:
- [**1. Code Smells**](Clean-Code-Fundamental-Part2.md#1-code-smells)
  - [1.1 Duplicated Code (Дублирование)](Clean-Code-Fundamental-Part2.md#11-duplicated-code-дублирование)
  - [1.2 Long Method (Длинная функция)](Clean-Code-Fundamental-Part2.md#12-long-method-длинная-функция)
  - [1.3 Large Class (Большой класс)](Clean-Code-Fundamental-Part2.md#13-large-class-большой-класс)
  - [1.4 Long Parameter List](Clean-Code-Fundamental-Part2.md#14-long-parameter-list)
  - [1.5 Magic Numbers и Magic Strings](Clean-Code-Fundamental-Part2.md#15-magic-numbers-и-magic-strings)
  - [1.6 Dead Code (Мёртвый код)](Clean-Code-Fundamental-Part2.md#16-dead-code-мёртвый-код)
  - [1.7 Primitive Obsession](Clean-Code-Fundamental-Part2.md#17-primitive-obsession)
  - [1.8 Switch Statements](Clean-Code-Fundamental-Part2.md#18-switch-statements)
  - [1.9 Shotgun Surgery](Clean-Code-Fundamental-Part2.md#19-shotgun-surgery)
- [**2. Организация кода**](Clean-Code-Fundamental-Part2.md#2-организация-кода)
  - [2.1 Форматирование](Clean-Code-Fundamental-Part2.md#21-форматирование)
  - [2.2 Порядок кода](Clean-Code-Fundamental-Part2.md#22-порядок-кода)
  - [2.3 Порядок импортов](Clean-Code-Fundamental-Part2.md#23-порядок-импортов)

### [Часть 3: Продвинутые практики чистого кода](Clean-Code-Fundamental-Part3.md)

Углубление в концепции чистого кода: работа с данными, асинхронностью и производительностью.

#### Разделы:
- [**1. Работа с данными**](Clean-Code-Fundamental-Part3.md#1-работа-с-данными)
  - [1.1 Избегать глобальных переменных](Clean-Code-Fundamental-Part3.md#11-избегать-глобальных-переменных)
  - [1.2 Использовать const по умолчанию](Clean-Code-Fundamental-Part3.md#12-использовать-const-по-умолчанию)
  - [1.3 Избегать мутации параметров](Clean-Code-Fundamental-Part3.md#13-избегать-мутации-параметров)
  - [1.4 Immutability (Неизменяемость)](Clean-Code-Fundamental-Part3.md#14-immutability-неизменяемость)
  - [1.5 Работа с массивами](Clean-Code-Fundamental-Part3.md#15-работа-с-массивами)
  - [1.6 Работа с объектами](Clean-Code-Fundamental-Part3.md#16-работа-с-объектами)
  - [1.7 Null и Undefined](Clean-Code-Fundamental-Part3.md#17-null-и-undefined)
- [**2. Асинхронный код**](Clean-Code-Fundamental-Part3.md#2-асинхронный-код)
  - [2.1 Promises](Clean-Code-Fundamental-Part3.md#21-promises)
  - [2.2 Async/Await](Clean-Code-Fundamental-Part3.md#22-async-await)
  - [2.3 Анти-паттерны](Clean-Code-Fundamental-Part3.md#23-анти-паттерны)

### [Часть 4: Производительность и тестируемость кода](Clean-Code-Fundamental-Part4.md)

Производительность, тестируемость кода и персональные практики.

#### Разделы:
- [**Производительность и тестирование**](Clean-Code-Fundamental-Part4.md#производительность-и-тестирование)
  - [**1 Преждевременная оптимизация**](Clean-Code-Fundamental-Part4.md#1-преждевременная-оптимизация)
  - [**1.1 Когда оптимизировать**](Clean-Code-Fundamental-Part4.md#11-когда-оптимизировать)
  - [**1.2 Простые оптимизации**](Clean-Code-Fundamental-Part4.md#12-простые-оптимизации)
  - [**2. Тестируемость кода**](Clean-Code-Fundamental-Part4.md#2-тестируемость-кода)
    - [2.1 Что делает код тестируемым](Clean-Code-Fundamental-Part4.md#21-что-делает-код-тестируемым)
    - [2.2 Признаки нетестируемого кода](Clean-Code-Fundamental-Part4.md#22-признаки-нетестируемого-кода)
    - [2.3 Рефакторинг для тестов](Clean-Code-Fundamental-Part4.md#23-рефакторинг-для-тестов)

### [Часть 5: Архитектурные паттерны и принципы](Clean-Code-Fundamentals-Part5.md)

Принципы SOLID - фундамент архитектуры приложений.

#### Разделы:
- [**1. SOLID Principles**](Clean-Code-Fundamentals-Part5.md#1-solid-principles)
  - [1. SOLID Principles](Clean-Code-Fundamentals-Part5.md#1-solid-principles)
  - [1.1 S - Single Responsibility Principle](Clean-Code-Fundamentals-Part5.md#11-s---single-responsibility-principle-принцип-единственной-ответственности)
  - [1.2 O - Open/Closed Principle](Clean-Code-Fundamentals-Part5.md#12-o---open-closed-principle-принцип-открытостизакрытости)
  - [1.3 L - Liskov Substitution Principle](Clean-Code-Fundamentals-Part5.md#13-l---liskov-substitution-principle-принцип-подстановки-барбары-лисков)
  - [1.4 I - Interface Segregation Principle](Clean-Code-Fundamentals-Part5.md#14-i---interface-segregation-principle-принцип-разделения-интерфейса)
  - [1.5 D - Dependency Inversion Principle](Clean-Code-Fundamentals-Part5.md#15-d---dependency-inversion-principle-принцип-инверсии-зависимостей)
- [**2. KISS (Keep It Simple, Stupid)**](Clean-Code-Fundamentals-Part5.md#2-kiss-keep-it-simple-stupid)
- [**3. DRY (Don't Repeat Yourself)**](Clean-Code-Fundamentals-Part5.md#3-dry-dont-repeat-yourself)
- [**4. YAGNI (You Aren't Gonna Need It)**](Clean-Code-Fundamentals-Part5.md#4-yagni-you-arent-gonna-need-it)
- [**5. Separation of Concerns**](Clean-Code-Fundamentals-Part5.md#5-separation-of-concerns-разделение-ответственности)
- [**6. Composition over Inheritance**](Clean-Code-Fundamentals-Part5.md#6-composition-over-inheritance-композиция-вместо-наследования)
- [**7. Fail Fast**](Clean-Code-Fundamentals-Part5.md#7-fail-fast-быстрый-отказ)

### [Часть 6: Дополнительные практики](Clean-Code-Fundamentals-Part6.md)

Остальные рекомендации и антипаттерны.

#### Разделы:
- [**1. Стрелочные функции для методов**](Clean-Code-Fundamentals-Part6.md#1-стрелочные-функции-для-методов)
- [**2. Осторожно с setTimeout и setInterval**](Clean-Code-Fundamentals-Part6.md#2-осторожно-с-settimeout-и-setinterval)

### [React Best Practices](React.md)

Лучшие практики разработки на React.

#### Разделы:
- [**1. Структура проекта и импорты**](React.md#1-структура-проекта-и-импорты)
  - [1.1 Использование alias для импортов](React.md#11-использование-alias-для-импортов)
  - [1.2 Порядок импортов](React.md#12-порядок-импортов)
  - [1.3 Структура компонента и импорты: как лучше делать](React.md#13-структура-компонента-и-импорты-как-лучше-делать)
  - [1.4 Именование файлов и папок](React.md#14-именование-файлов-и-папок)
- [**2. Компоненты React**](React.md#2-компоненты-react)
  - [2.1 Стрелочные функции для компонентов](React.md#21-стрелочные-функции-для-компонентов)
  - [2.2 Типизация компонентов](React.md#22-типизация-компонентов)
  - [2.3 Использование `React.memo()`](React.md#23-использование-reactmemo)
  - [2.4 Разбиение больших компонентов](React.md#24-разбиение-больших-компонентов)
  - [2.5 Обработчики событий](React.md#25-обработчики-событий)
  - [2.6 Сокращение кода через destructuring](React.md#26-сокращение-кода-через-destructuring)
- [**3. Хуки React**](React.md#3-хуки-react)
  - [3.1 `useCallback`](React.md#31-usecallback)
  - [3.2 Вынесение логики в кастомные хуки](React.md#32-вынесение-логики-в-кастомные-хуки)
  - [3.3 `AbortController` в `useEffect`](React.md#33-abortcontroller-в-useeffect)
- [**4. Оптимизация и производительность**](React.md#4-оптимизация-и-производительность)
  - [4.1 Условный рендеринг](React.md#41-условный-рендеринг)
  - [4.2 Оптимизация импортов из библиотек](React.md#42-оптимизация-импортов-из-библиотек)
  - [4.3 Вынос сложных вычислений в переменные](React.md#43-вынос-сложных-вычислений-в-переменные)
- [**5. Работа с формами**](React.md#5-работа-с-формами)
  - [5.1 Атрибут `autoComplete`](React.md#51-атрибут-autocomplete)
  - [5.2 Валидация и обработка ошибок](React.md#52-валидация-и-обработка-ошибок)
- [**6. Работа с темами**](React.md#6-работа-с-темами)
  - [6.1 Глобальные CSS переменные вместо `useTheme`](React.md#61-глobальные-css-переменные-вместо-usetheme)
- [**7. Next.js Best Practices**](React.md#7-nextjs-best-practices)
  - [7.1 Использование `Link` вместо кастомной навигации](React.md#71-использование-link-вместо-кастомной-навигации)
- [**8. Антипаттерны React**](React.md#8-антипаттерны-react)
  - [8.1 НЕ использовать `dangerouslySetInnerHTML`](React.md#81-не-использовать-dangerouslysetinnerHTML)
  - [8.2 Всегда добавлять `key` в `map()`](React.md#82-всегда-добавлять-key-в-map)
  - [8.3 Удалять `console.log()` перед продакшеном](React.md#83-удалять-consolelog-перед-продакшеном)
  - [8.4 Удалять комментарии перед финальным PR](React.md#84-удалять-комментарии-перед-финальным-pr)

### [TypeScript Best Practices](TypeScript.md)

Лучшие практики разработки на TypeScript.

#### Разделы:
- [**1. Основы типизации**](TypeScript.md#1-основы-типизации)
  - [1.1 Запрет `any`](TypeScript.md#11-запрет-any)
  - [1.2 Использование `unknown` вместо `any`](TypeScript.md#12-использование-unknown-вместо-any)
  - [1.3 Запрет `{}` и `object`](TypeScript.md#13-запрет--и-object)
  - [1.4 Явные типы возврата функций](TypeScript.md#14-явные-типы-возврата-функций)
- [**2. `type` vs `interface`**](TypeScript.md#2-type-vs-interface)
  - [2.1 Когда использовать `type`](TypeScript.md#21-когда-использовать-type)
  - [2.2 Когда использовать `interface`](TypeScript.md#22-когда-использовать-interface)
- [**3. Enum vs const объекты**](TypeScript.md#3-enum-vs-const-объекты)
  - [3.1 Почему `enum` — это плохо](TypeScript.md#31-почему-enum--это-плохо)
  - [3.2 Использование `as const`](TypeScript.md#32-использование-as-const)
- [**4. Type Guards и Type Assertions**](TypeScript.md#4-type-guards-и-type-assertions)
  - [4.1 Type Assertion (`as`)](TypeScript.md#41-type-assertion-as)
  - [4.2 Type Guards (`typeof`, `instanceof`, `is`)](TypeScript.md#42-type-guards-typeof-instanceof-is)
- [**5. Константы и Magic Values**](TypeScript.md#5-константы-и-magic-values)
  - [5.1 Вынос числовых значений](TypeScript.md#51-вынос-числовых-значений)
  - [5.2 Вынос строк в константы](TypeScript.md#52-вынос-строк-в-константы)
  - [5.3 Использование `as const` для объектов](TypeScript.md#53-использование-as-const-для-объектов)
- [**6. Настройка TypeScript**](TypeScript.md#6-настройка-typescript)
  - [6.1 Строгие правила в `tsconfig.json`](TypeScript.md#61-строгие-правила-в-tsconfigjson)
  - [6.2 ESLint правила](TypeScript.md#62-eslint-правила)

### [Чеклист Code Review: Clean Code](Check-List.md)

Практический чеклист для проведения код-ревью согласно принципам чистого кода.

## 🎯 Как использовать материалы

1. **Изучайте по темам** — каждая глава посвящена конкретной практике
2. **Смотрите примеры** — в каждом разделе есть примеры "плохо-хорошо"
3. **Применяйте на практике** — пробуйте рефакторить свой код
4. **Используйте при код-ревью** — проверяйте эти правила при проверке PR

## 📖 Дополнительные ресурсы

- [Clean Code: A Handbook of Agile Software Craftsmanship](https://www.oreilly.com/library/view/clean-code-a/9780136083238/) — Роберт Мартин
- [Refactoring: Improving the Design of Existing Code](https://martinfowler.com/books/refactoring.html) — Мартин Фаулер
- [The Pragmatic Programmer](https://pragprog.com/titles/tpp20/the-pragmatic-programmer-20th-anniversary-edition/) — Эндрю Хант и Дэвид Томас

## 🔄 Поддержка материалов

Материалы регулярно обновляются. Предложения по улучшению приветствуются!

---
*Последнее обновление: ноябрь 2025*
