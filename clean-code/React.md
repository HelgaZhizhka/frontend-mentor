# React Best Practices

## 1. Структура проекта и импорты

### 1.1 Использование alias для импортов

**Проблема:** Длинные относительные пути (`../../../`) усложняют код и навигацию.

**❌ Плохо:**

```typescript
import { Button } from '../../../components/ui/button';
import { Card } from '../../../../components/common/card';
```

**✅ Хорошо — через `alias` в `tsconfig.json`:**

```typescript
import { Button } from '@/components/ui/button';
import { Card } from '@/components/common/card';
```

**Настройка в `tsconfig.json`:**

```json
{
  "compilerOptions": {
    "baseUrl": "./",
    "paths": {
      "@/*": ["src/*"],
      "@components/*": ["src/components/*"],
      "@utils/*": ["src/utils/*"],
      "@hooks/*": ["src/hooks/*"],
      "@types/*": ["src/types/*"]
    }
  }
}
```

**Настройка в `vite.config.ts`:**

```typescript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { dirname, resolve } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: [
      {
        find: '@',
        replacement: resolve(__dirname, './src'),
      },
      {
        find: '@images',
        replacement: resolve(__dirname, './src/assets/images'),
      },
    ],
  },
});
```

### 1.2 Порядок импортов

**Правило:** Импорты идут **от дальних к ближним** (глобальные → локальные).
**Рекомендуемая структура:**

```typescript
// 1. Встроенные модули Node.js (если есть)
import fs from 'fs';
import path from 'path';

// 2. Внешние библиотеки (npm-пакеты)
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

// 3. Глобальные файлы проекта
import { ROUTES } from '@/constants/routes';
import { formatDate } from '@/utils/dateUtils';

// 4. Контекст / хуки / глобальные состояния
import { AuthProvider } from '@/context/auth-context';
import { useAuth } from '@/hooks/use-auth';

// 5. Компоненты
import { Header } from '@/components/header';
import { Button } from '@/components/ui/button';

// 6. Локальные модули (относящиеся к текущему компоненту)
import { UserCard } from './user-card';
import styles from './styles.module.css';
```

**✅ Рекомендуется разделять пустой строкой импорты из библиотеки и локальные импорты**
**Автоматизация:**

- Включить авто-сортировку в настройках VS Code
- Использовать плагин `eslint-plugin-import`

### 1.3 Структура компонента и импорты: как лучше делать

**Рекомендуемый паттерн:**

- Каждый компонент — это папка с именем в формате `kebab-case`.
- В папке только один главный файл: `index.tsx` (`index.ts` для "чистых" TypeScript-компонентов).
- В этой же папке лежат стили `styles.module.css` (или `.scss`), тесты и типы, если нужны.
- **Всегда используем именованный экспорт!**  
  (`export const Card...` а не `export default`)
- Импорт компонента: только по папке.

**Пример структуры:**

```
components/
  user-profile/
    index.tsx
    styles.module.css
    user-profile.test.tsx
  card-list/
    index.tsx
    styles.module.css
```

#### Пример компонента

```typescript
// components/card-list/index.tsx
import type { ReactNode } from 'react'

import { cn } from '@/utils/classnames'
import styles from './styles.module.css'

export type CardListProps = {
  children: ReactNode
  className?: string
}

export const CardList = ({
  children,
  className,
}: CardListProps): React.JSX.Element => (
  <div className={cn(styles.root, className)}>{children}</div>
)
```

**Импорт в других частях приложения:**

```typescript
import { CardList } from '@/components/card-list';
```

#### Почему именно так?

- **kebab-case** для папок и файлов стандартизирует проект, предотвращает баги в разных ОС и не ломает git.
- Разбиение по папкам сжатого вида позволяет удобно складывать стили, тесты, типы ≈ один компонент = одна самостоятельная единица.

- **Именованные экспорты** легче автодополняются IDE, уменьшают ошибки и не путают с default-переносом — это и для TypeScript, и для рефакторинга лучше.
- Нет лишних barrel-exports (глобальных index.ts): tree-shaking работает идеально, проект масштабируется без боли.
- Git всегда видит разницу между `UserProfile` и `userProfile` — меньше конфликтов при командной работе.

**Настройка чувствительности к регистру на Git:**

```bash
git config core.ignorecase false
```

#### Пример шаблона для нового компонента (boilerplate):

```
components/
  my-component/
    index.tsx
    styles.module.css
    my-component.test.tsx
```

```typescript
// components/my-component/index.tsx

import type { ReactNode } from 'react'
import styles from './styles.module.css'

export type MyComponentProps = {
  children: ReactNode
  className?: string
}

export const MyComponent = ({ children, className }: MyComponentProps): React.JSX.Element => (
  <div className={cn(styles.root, className)}>{children}</div>
)
```

---

- **Одна папка = один компонент**  
  (kebab-case, index.tsx — экспорт именованный)

- **Импорт максимально короткий:**  
  `import { Button } from '@/components/button'`

## 2. Компоненты React

### 2.1 Стрелочные функции для компонентов

**✅ Хорошая практика — компоненты как стрелочные функции:**

```typescript
// Компонент без пропсов
const App = (): React.JSX.Element => {
  return <div className="App">Hello World</div>
}

export default App
```

**Компонент с пропсами:**

```typescript
type ButtonProps = {
  label: string
  onClick: () => void
  disabled?: boolean
}

const Button = ({
  label,
  onClick,
  disabled = false,
}: ButtonProps): React.JSX.Element => {
  return (
    <button onClick={onClick} disabled={disabled}>
      {label}
    </button>
  )
}

export default Button
```

**С destructuring:**

```typescript
const UserCard = ({ user }: { user: User }): React.JSX.Element => {
  const { name, email, avatar } = user

  return (
    <div>
      <img src={avatar} alt={name} />
      <h2>{name}</h2>
      <p>{email}</p>
    </div>
  )
}
```

### 2.2 Типизация компонентов

**В React 18+ FC больше не включает children автоматически**

**Использование PropsWithChildren:**

```typescript
import { PropsWithChildren } from 'react';

const Container = ({
  title,
  children,
}: PropsWithChildren<{ title: string }>): React.JSX.Element => {
  return (
    <div>
      <h1>{title}</h1>
      {children}
    </div>
  )
}
```

Преимущества:

- Меньше кода (не нужно вручную типизировать children)
- Официальный utility type от React
- Явно показывает, что компонент принимает children
- children автоматически типизируется как ReactNode | undefined

**Явная типизация `children`:**

```typescript
type ContainerProps = {
  title: string
  children?: React.ReactNode
}

const Container = ({ title, children }: ContainerProps): React.JSX.Element => {
  return (
    <div>
      <h1>{title}</h1>
      {children}
    </div>
  )
}
```

Когда использовать:

- Нужен контроль над optional/required
- Нужно сделать children обязательным: children: React.ReactNode (без ?)
- Явная документация в интерфейсе

**Типы для `children`:**

```typescript
// Любой React элемент
children: React.ReactNode;
// Только один элемент
children: React.ReactElement;
// Только строка или число
children: string | number;
// Функция как child
children: (value: number) => React.ReactNode;
```

### 2.3 Использование `React.memo()`

**Когда использовать:**

- Компонент часто ререндерится с теми же пропсами
- Компонент тяжёлый (сложные вычисления или большой UI)

**✅ С `displayName` для отладки:**

```typescript
const UserCard = ({ user }: { user: User }): React.JSX.Element => {
  return (
    <div>
      <h2>{user.name}</h2>
      <p>{user.email}</p>
    </div>
  )
}

UserCard.displayName = 'UserCard'

export default React.memo(UserCard)
```

**С кастомным сравнением:**

```typescript
const areEqual = (prevProps: Props, nextProps: Props) => {
  return prevProps.user.id === nextProps.user.id;
};

export default React.memo(UserCard, areEqual);
```

### 2.4 Разбиение больших компонентов

**❌ Плохо — один большой компонент:**

```typescript
const UserProfile = (): React.JSX.Element => {
  return (
    <div>
      <header>
        <img src={avatar} />
        <h1>{name}</h1>
      </header>
      <nav>
        <ul>
          <li>Profile</li>
          <li>Settings</li>
        </ul>
      </nav>
      <main>
        <section>Bio</section>
        <section>Posts</section>
      </main>
      <footer>Footer</footer>
    </div>
  )
}
```

**✅ Хорошо — разбито на подкомпоненты:**

```typescript
const UserProfile = (): React.JSX.Element => {
  return (
    <div>
      <UserHeader />
      <UserNav />
      <UserMain />
      <UserFooter />
    </div>
  )
}
```

### 2.5 Обработчики событий

**Если функция простая — можно не выносить:**

```typescript
const Pagination = (): React.JSX.Element => {
  const [currentPage, setCurrentPage] = useState(1)

  return (
    <div>
      <button onClick={() => setCurrentPage(currentPage - 1)}>Previous</button>
      <span>{currentPage}</span>
      <button onClick={() => setCurrentPage(currentPage + 1)}>Next</button>
    </div>
  )
}
```

**Если сложная — выносим:**

```typescript
const Form = (): React.JSX.Element => {
  const [formData, setFormData] = useState({ name: '', email: '' })

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Сложная логика валидации
    validateForm(formData)
    // Отправка данных
    submitForm(formData)
  }

  return <form onSubmit={handleSubmit}>{/* ... */}</form>
}
```

### 2.6 Сокращение кода через destructuring

**❌ Плохо:**

```typescript
const onChange = (e: React.ChangeEvent<HTMLInputElement>) => {
  const newPassword = e.target.value;
  setPassword(newPassword);
};
```

**✅ Хорошо:**

```typescript
const onChange = ({ target: { value } }: React.ChangeEvent<HTMLInputElement>) => {
  setPassword(value);
};
```

### 3. Хуки React

#### 3.1 `useCallback`

**Когда `useCallback` НУЖЕН:**

**1️⃣ Функция передаётся в дочерний компонент с `React.memo()`:**

```typescript
const Parent = (): React.JSX.Element => {
  const [count, setCount] = useState(0)

  const handleClick = useCallback(() => {
    console.log('Clicked!')
  }, [])

  return (
    <div>
      <button onClick={() => setCount(count + 1)}>Increment</button>
      <Child onClick={handleClick} />
    </div>
  )
}

const Child = React.memo<{ onClick: () => void }>(({ onClick }) => {
  console.log('Child rendered')
  return <button onClick={onClick}>Click me</button>
})
```

✅ Теперь `Child` **не перерисовывается при каждом изменении `count`**!

**2️⃣ Функция передаётся в `useEffect`:**

```typescript
const Component = (): React.JSX.Element => {
  const fetchData = useCallback(() => {
    console.log('Fetching data...')
  }, [])

  useEffect(() => {
    fetchData()
  }, [fetchData]) // ✅ Без useCallback этот useEffect запускался бы при каждом ререндере!

  return <div>Content</div>
}
```

**3️⃣ Функция используется в `setInterval`, `setTimeout` или `eventListener`:**

```typescript
const Component = (): React.JSX.Element => {
  const [count, setCount] = useState(0)

  const tick = useCallback(() => {
    setCount((prev) => prev + 1)
  }, [])

  useEffect(() => {
    const interval = setInterval(tick, 1000)
    return () => clearInterval(interval)
  }, [tick]) // ✅ Теперь `tick` будет всегда актуальным!

  return <div>{count}</div>
}
```

**❌ Когда `useCallback` НЕ НУЖЕН:**

**1️⃣ Если функция вызывается только внутри компонента:**

```typescript
const Component = (): React.JSX.Element => {
  const handleClick = () => {
    console.log('Clicked!')
  }

  return <button onClick={handleClick}>Click me</button>
}
```

❌ **`useCallback` не нужен**, потому что `handleClick` не передаётся никуда дальше!

**2️⃣ Функция создаётся прямо в обработчике:**

```typescript
<button onClick={() => console.log('Clicked!')}>Click me</button>
```

❌ **Здесь `useCallback` не нужен**

### 3.2 Вынесение логики в кастомные хуки

**Проблема:** Логика загрузки данных дублируется в разных компонентах.

**✅ Решение — кастомный хук `usePeople.ts`:**

```typescript
import { useState, useEffect } from 'react';
import { getAllPeople, searchPeople } from '@/services/api';
import { Person } from '@/types';

export const usePeople = (query: string, page: number) => {
  const [people, setPeople] = useState<Person[]>([]);
  const [totalCount, setTotalCount] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const [hasError, setHasError] = useState(false);

  useEffect(() => {
    const controller = new AbortController();
    const { signal } = controller;

    const fetchPeople = async () => {
      setIsLoading(true);
      setHasError(false);

      try {
        const data = query
          ? await searchPeople(query, page, signal)
          : await getAllPeople(page, signal);

        setPeople(data.results);
        setTotalCount(data.count);
      } catch (error) {
        if (error.name !== 'AbortError') {
          console.error('Error loading people:', error);
          setHasError(true);
        }
      } finally {
        setIsLoading(false);
      }
    };

    fetchPeople();

    return () => controller.abort();
  }, [query, page]);

  return { people, totalCount, isLoading, hasError };
};
```

**Использование в компоненте:**

```typescript
const MainPage = (): React.JSX.Element => {
  const [query, setQuery] = useState('')
  const [page, setPage] = useState(1)

  const { people, totalCount, isLoading, hasError } = usePeople(query, page)

  if (isLoading) return <div>Loading...</div>
  if (hasError) return <div>Error loading data</div>

  return (
    <div>
      {people.map((person) => (
        <PersonCard key={person.id} person={person} />
      ))}
    </div>
  )
}
```

**Преимущества:**

- ✅ Чище код в компонентах
- ✅ Можно переиспользовать логику в разных местах
- ✅ Избегаем дублирования `useEffect` и `useState`

### 3.3 `AbortController` в `useEffect`

**Проблема:** Если компонент размонтируется до завершения запроса, React выдаст ошибку:

```
Warning: Can't perform a React state update on an unmounted component.
```

**✅ Решение — отменять запрос с `AbortController`:**

```typescript
useEffect(() => {
  const controller = new AbortController();

  const fetchData = async () => {
    try {
      const response = await fetch('https://api.example.com/data', {
        signal: controller.signal,
      });
      const data = await response.json();
      setData(data);
    } catch (error) {
      if (error.name !== 'AbortError') {
        console.error('Ошибка загрузки:', error);
      }
    }
  };

  fetchData();

  return () => {
    controller.abort(); // ✅ Отменяем запрос при размонтировании
  };
}, []);
```

**Когда `AbortController` нужен:**

| Сценарий                         | Нужен `AbortController`? | Почему?                                               |
| -------------------------------- | ------------------------ | ----------------------------------------------------- |
| Одноразовый запрос в `useEffect` | ✅ **Да**                | Если компонент размонтируется, запрос отменяется      |
| `useEffect` с `setInterval`      | ✅ **Да**                | Нужно отменять запросы перед каждым повторным вызовом |
| Синхронные операции              | ❌ **Нет**               | Запрос сразу выполняется, `abort` не нужен            |

## 4. Оптимизация и производительность

### 4.1 Условный рендеринг

**Early return для условий:**

```typescript
const UserProfile = ({ user }: { user: User | null }): React.JSX.Element => {
  if (!user) return <div>No user found</div>

  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </div>
  )
}
```

**Избегать длинных тернарных операторов:**

```typescript
// ❌ Плохо — сложно читать
return (
  <div>
    {isLoading ? (
      <Spinner />
    ) : hasError ? (
      <ErrorMessage />
    ) : data ? (
      <DataView data={data} />
    ) : (
      <EmptyState />
    )}
  </div>
)
// ✅ Хорошо — early returns
if (isLoading) return <Spinner />
if (hasError) return <ErrorMessage />
if (!data) return <EmptyState />

return <DataView data={data} />
```

### 4.2 Оптимизация импортов из библиотек

**❌ Плохо — импорт всей библиотеки:**

```typescript
import * as MUI from '@mui/material'

const App = () => <MUI.Button>Click</MUI.Button>
```

**✅ Хорошо — именованный импорт конкретных компонентов:**

```typescript
import Button from '@mui/material/Button'
import Switch from '@mui/material/Switch'

const App = () => <Button>Click</Button>
```

**Преимущества:**

- Меньше размер бандла
- Быстрее загрузка
- Tree shaking работает эффективнее

### 4.3 Вынос сложных вычислений в переменные

**❌ Плохо — длинные вычисления в JSX:**

```typescript
<div
  className={classNames(
    styles.root,
    variant === LogoVariant.WHITE && styles.logoWhite,
    darkMode && styles.dark
  )}
>
```

**✅ Хорошо — вынесено в переменную:**

```typescript
const className = classNames(
  styles.root,
  variant === LogoVariant.WHITE && styles.logoWhite,
  darkMode && styles.dark
);

return <div className={className}>;
```

## 5. Работа с формами

### 5.1 Атрибут `autoComplete`

**Улучшает UX — браузер может автоматически заполнять поля:**

```typescript
<input
  type="text"
  name="firstName"
  autoComplete="given-name"
/>

<input
  type="email"
  name="email"
  autoComplete="email"
/>

<input
  type="password"
  name="password"
  autoComplete="new-password"
/>

<input
  type="password"
  name="currentPassword"
  autoComplete="current-password"
/>
```

**Полезные значения:**

- `name` или `given-name` — имя
- `nickname` — никнейм
- `email` — email
- `new-password` — новый пароль
- `current-password` — текущий пароль
- `tel` — телефон
- `street-address` — адрес

### 5.2 Валидация и обработка ошибок

```typescript
type FormState = {
  email: string
  password: string
  errors: {
    email?: string
    password?: string
  }
}
const LoginForm = (): React.JSX.Element => {
  const [formState, setFormState] = useState<FormState>({
    email: '',
    password: '',
    errors: {},
  })

  const validateEmail = (email: string): string | undefined => {
    if (!email) return 'Email is required'
    if (!/\S+@\S+\.\S+/.test(email)) return 'Email is invalid'
    return undefined
  }

  const validatePassword = (password: string): string | undefined => {
    if (!password) return 'Password is required'
    if (password.length < 8) return 'Password must be at least 8 characters'
    return undefined
  }

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()

    const errors = {
      email: validateEmail(formState.email),
      password: validatePassword(formState.password),
    }

    if (errors.email || errors.password) {
      setFormState({ ...formState, errors })
      return
    }

    submitForm(formState)
  }

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={formState.email}
        onChange={({ target: { value } }) =>
          setFormState({ ...formState, email: value })
        }
        autoComplete="email"
      />
      {formState.errors.email && (
        <span className="error">{formState.errors.email}</span>
      )}

      <button type="submit">Submit</button>
    </form>
  )
}
```

## 6. Работа с темами

### 6.1 Глобальные CSS переменные вместо useTheme

**Проблема:** `useTheme` в каждом компоненте вызывает лишние ререндеры.

**✅ Решение — CSS переменные + атрибут `data-theme`:**

**В `ThemeProvider`:**

```typescript
const ThemeProvider = ({
  children,
}: {
  children: React.ReactNode
}): React.JSX.Element => {
  const [theme, setTheme] = useState<'light' | 'dark'>('light')

  useEffect(() => {
    document.body.setAttribute('data-theme', theme)
  }, [theme])

  return (
    <ThemeContext.Provider value={{ theme, setTheme }}>
      {children}
    </ThemeContext.Provider>
  )
}
```

**В CSS:**

```css
:root {
  --white: #fff;
  --dark: #212529;
  --light: #f4f4f4;
  --body-bg: var(--white);
  --color-text: var(--dark);
  --input-bg: var(--white);
  --component-bg: rgba(255, 255, 255, 0.4);
}

body[data-theme='dark'] {
  --body-bg: var(--dark);
  --color-text: var(--light);
  --input-bg: var(--black);
  --component-bg: rgba(33, 37, 41, 0.4);
}
```

**В компонентах:**

```css
.card {
  background-color: var(--component-bg);
  color: var(--color-text);
}
```

**Преимущества:**

- ✅ Нет лишних ререндеров
- ✅ Проще поддерживать
- ✅ CSS переменные работают быстрее

## 7. Next.js Best Practices

### 7.1 Использование `Link` вместо кастомной навигации

**❌ Плохо — ручная навигация:**

```typescript
const handleClick = () => {
  router.push('/profile')
}
<button onClick={handleClick}>Go to Profile</button>
```

**✅ Хорошо — компонент `Link`:**

```typescript
import Link from 'next/link'
<Link href="/profile">Go to Profile</Link>
```

**Преимущества:**

- Автоматическая предзагрузка страниц
- Лучшая производительность
- SEO-оптимизация

## 8. Антипаттерны React

### 8.1 НЕ использовать `dangerouslySetInnerHTML`

**❌ Опасно — XSS уязвимость:**

```typescript
<div dangerouslySetInnerHTML={{ __html: userContent }} />
```

**✅ Безопасно — рендерить как текст или использовать библиотеку:**

```typescript
// Вариант 1: как текст
<div>{userContent}</div>
// Вариант 2: с санитизацией через DOMPurify
import DOMPurify from 'dompurify'
const sanitizedHTML = DOMPurify.sanitize(userContent)
<div dangerouslySetInnerHTML={{ __html: sanitizedHTML }} />
```

### 8.2 Всегда добавлять `key` в `map()`

**❌ Плохо:**

```typescript
items.map((item) => <Card name={item.name} />)
```

**✅ Хорошо:**

```typescript
items.map((item) => <Card key={item.id} name={item.name} />)
```

### 8.3 Удалять `console.log()` перед продакшеном

**❌ Плохо:**

```typescript
console.log('Fetching user...');
fetchUser();
```

**✅ Хорошо — использовать logger:**

```typescript
import { logger } from '@/utils/logger';
logger.debug('Fetching user...');
fetchUser();
```

### 8.4 Удалять комментарии перед финальным PR

**Комментарии должны быть актуальны и полезны. Удаляй:**

- Закомментированный код
- TODO без даты
- Очевидные комментарии

## Чек-лист: React Best Practices

### ✅ Структура

- [ ] Используются alias для импортов
- [ ] Порядок импортов правильный
- [ ] Файлы в `kebab-case`
- [ ] Реэкспорт через `index.ts`

### ✅ Компоненты

- [ ] Стрелочные функции для компонентов
- [ ] Правильная типизация пропсов
- [ ] `React.memo()` где нужно
- [ ] Большие компоненты разбиты
- [ ] `displayName` указан для `memo`

### ✅ React и DOM

- [ ] Нет использования `querySelector`, `getElementById`, `getElementsByClassName`
- [ ] Нет прямых манипуляций с DOM
- [ ] `useRef` используется только для фокуса, скролла, измерений или сторонних библиотек
- [ ] Все изменения UI через состояние (`useState`, `useReducer`)
- [ ] Формы используют controlled components
- [ ] Условный рендеринг вместо `display: none/block`

### ✅ Хуки

- [ ] `useCallback` используется правильно
- [ ] Логика вынесена в кастомные хуки
- [ ] `AbortController` в `useEffect`

### ✅ Производительность

- [ ] Early return для условий
- [ ] Именованные импорты из библиотек
- [ ] Сложные вычисления вынесены

### ✅ Формы

- [ ] `autoComplete` указан
- [ ] Валидация на клиенте
- [ ] Понятные сообщения об ошибках

### ✅ Антипаттерны

- [ ] Нет `dangerouslySetInnerHTML`
- [ ] `key` везде где нужно
- [ ] Нет `console.log()`
- [ ] Нет закомментированного кода
