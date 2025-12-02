# TypeScript Best Practices

## 1. Основы типизации

### 1.1 Запрет `any`

**Почему `any` – это плохо?**

- Он отключает проверку типов, и **код становится незащищённым**
- TypeScript перестаёт помогать отлавливать ошибки
- Теряется смысл использования TypeScript
  **❌ Плохо:**

```typescript
const processData = (data: any) => {
  return data.map((item) => item.value); // ❌ Ошибки не поймаем
};

const users: any = fetchUsers();
const items: Array<any> = getItems();
const result: Promise<any> = loadData();
```

**✅ Хорошо:**

```typescript
interface Item {
  value: string;
}

const processData = (data: Item[]) => {
  return data.map((item) => item.value);
};

const users: User[] = fetchUsers();
const items: Item[] = getItems();
const result: Promise<Data> = loadData();
```

**Настройка запрета `any`:**

**В `tsconfig.json`:**

```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true
  }
}
```

**В `.eslintrc.js`:**

```javascript
module.exports = {
  rules: {
    '@typescript-eslint/no-explicit-any': 'error',
  },
};
```

### 1.2 Использование `unknown` вместо `any`

**Правило:**

- **Используем `unknown` вместо `any`**, если не знаем, какой будет тип
- **Только через проверку или `as` приводим `unknown` к нужному типу**

**❌ Плохо — `any` отключает проверки TypeScript:**

```typescript
const processData = (data: any) => {
  return data.map((item) => item.value); // ❌ Ошибки не поймаем
};
```

**✅ Хорошо — `unknown` требует явного приведения типа:**

```typescript
const processData = (data: unknown) => {
  if (!Array.isArray(data)) throw new Error('Invalid data');
  return data.map((item) => (item as { value: string }).value);
};
```

**Пример обработки ошибок в `catch` с `unknown`:**

```typescript
try {
  throw new Error('Something went wrong');
} catch (error: unknown) {
  if (error instanceof Error) {
    console.error(error.message);
  } else {
    console.error('Unexpected error', error);
  }
}
```

**Или с функцией-помощником:**

```typescript
const getErrorMessage = (error: unknown): string => {
  if (error instanceof Error) {
    return error.message;
  }

  if (typeof error === 'string') {
    return error;
  }

  return 'Unknown error occurred';
};

try {
  throw 'Something went wrong';
} catch (error: unknown) {
  console.error(getErrorMessage(error));
}
```

### 1.3 Запрет `{}` и `object`

**Проблема:**

- `{}` и `object` слишком общие → **не дают нормальной типизации**
- Лучше использовать **`Record<string, string>`** или **`unknown`**

**❌ Плохо — `object` ничего не гарантирует:**

```typescript
const processUser = (user: object) => {
  console.log(user.name); // ❌ Ошибка! TS не знает, что есть `name`: Свойство "name" не существует в типе "object"
};
```

**✅ Хорошо — `Record<string, string>` или `unknown` + приведение типа:**

```typescript
const processUser = (user: Record<string, string>) => {
  console.log(user.name); // ✅ Теперь `name` точно строка
};

// Или с интерфейсом
interface User {
  name: string;
  age: number;
}

const processUser = (user: User) => {
  console.log(user.name); // ✅ Типизация работает
};
```

### 1.4 Явные типы возврата функций

**Почему это важно:**

- Предотвращает непреднамеренные типы возврата (TypeScript может выводить неправильные типы)
- Делает функциональные подписи более ясными для товарищей по команде
- Помогает TypeScript ловить ошибки на раннем этапе (особенно в асинхронных функциях)

**❌ Плохо — TypeScript выводит тип, но не всегда корректен:**

```typescript
const getUser = (id: string) => {
  return fetch(`/users/${id}`).then((res) => res.json());
};
```

**✅ Хорошо — явный тип возврата обеспечивает безопасность типа:**

```typescript
interface User {
  id: string;
  name: string;
  email: string;
}

const getUser = (id: string): Promise<User> => {
  return fetch(`/users/${id}`).then((res) => res.json());
};
```

**Примеры:**

```typescript
// ✅ Простая функция
const add = (a: number, b: number): number => a + b;

// ✅ Функция с объектом
const formatUser = (user: User): string => `${user.name} (${user.email})`;

// ✅ Async функция
const fetchData = async (url: string): Promise<Data> => {
  const response = await fetch(url);
  return response.json();
};

// ✅ Функция без возврата
const logMessage = (message: string): void => {
  console.log(message);
};
```

**Теперь функции всегда возвращают ожидаемый тип — никаких сюрпризов!**

## 2. `type` vs `interface`

### 2.1 Когда использовать `type`

**Рекомендация:**

- Если **не нужно расширять типы**, **используем `type`**
- Более гибкий, можно использовать union types, intersection types

**✅ Используем `type`, если не надо расширять:**

```typescript
type ButtonProps = {
  label: string;
  onClick: () => void;
};

type Status = 'pending' | 'success' | 'error';

type ID = string | number;

type Point = {
  x: number;
  y: number;
};
```

**Union и Intersection types:**

```typescript
// Union types
type Result = Success | Error;

type Success = {
  status: 'success';
  data: string;
};

type Error = {
  status: 'error';
  message: string;
};

// Intersection types
type Named = {
  name: string;
};

type Aged = {
  age: number;
};

type Person = Named & Aged;
```

### 2.2 Когда использовать `interface`

**Рекомендация:**

- Если **нужно расширять (`extends`)** – лучше **`interface`**
- В **команде** → **смотрим, что уже используется, и следуем стандарту**

**✅ Используем `interface`, если нужно `extends`:**

```typescript
interface BaseProps {
  id: string;
}

interface ButtonProps extends BaseProps {
  label: string;
  onClick: () => void;
}

interface User extends BaseProps {
  name: string;
  email: string;
}
```

**Расширение нескольких интерфейсов:**

```typescript
interface Named {
  name: string;
}

interface Aged {
  age: number;
}

interface Person extends Named, Aged {
  email: string;
}
```

**Declaration Merging:**

```typescript
// Интерфейсы могут объединяться
interface Window {
  customProperty: string;
}

interface Window {
  anotherProperty: number;
}
// Теперь Window имеет оба свойства
```

## 3. Enum vs const объекты

### 3.1 Почему `enum` — это плохо

**Проблемы `enum`:**

- Генерирует лишний код в JavaScript
- Ломает `Object.keys`
- Не всегда работает как ожидается
- Занимает больше места в бандле

**❌ Плохо — `enum` генерирует лишний код в JS:**

```typescript
enum Role {
  Admin = 'admin',
  User = 'user',
}

// Генерирует в JS:
var Role;
(function (Role) {
  Role['Admin'] = 'admin';
  Role['User'] = 'user';
})(Role || (Role = {}));
```

**Когда `enum` допустим:**

Есть несколько случаев, когда использование `enum` оправдано:

**1. `const enum` — полностью удаляется из JS:**

```typescript
const enum Status {
  Pending = 0,
  Success = 1,
  Error = 2,
}

const status = Status.Success; // В JS будет: const status = 1

// ✅ Никакого лишнего кода в бандле!
```

**2. Numeric enum с reverse mapping:**

```typescript
enum HttpStatus {
  OK = 200,
  NotFound = 404,
  InternalError = 500,
}

// Можно получить имя по значению
console.log(HttpStatus[200]); // "OK"
console.log(HttpStatus.OK); // 200
```

**3. Когда требуется совместимость с внешними библиотеками:**
Если библиотека использует enum в типах, вам придется использовать их.

**Рекомендация:** В 95% случаев используйте `as const` вместо `enum`. Используйте `const enum` только если критична оптимизация бандла и не нужен reverse mapping.

### 3.2 Использование `as const`

**✅ Хорошо — `as const` делает объект `readonly`, оптимальный вариант!**

```typescript
const Role = {
  Admin: 'admin',
  User: 'user',
} as const;

type RoleType = (typeof Role)[keyof typeof Role]; // "admin" | "user"
```

**Теперь `RoleType` будет `"admin" | "user"`, и не будет лишнего кода в JS!**

**Примеры использования:**

```typescript
const ROUTES = {
  HOME: '/',
  ABOUT: '/about',
  CONTACT: '/contact',
} as const;

type Route = (typeof ROUTES)[keyof typeof ROUTES];

// Использование
const navigateTo = (route: Route) => {
  console.log(`Navigating to ${route}`);
};

navigateTo(ROUTES.HOME); // ✅
navigateTo('/profile'); // ❌ Type error
```

**Для статусов:**

```typescript
const STATUS = {
  PENDING: 'pending',
  SUCCESS: 'success',
  ERROR: 'error',
} as const;

type Status = (typeof STATUS)[keyof typeof STATUS];

const handleStatus = (status: Status) => {
  if (status === STATUS.SUCCESS) {
    console.log('Success!');
  }
};
```

## 4. Type Guards и Type Assertions

### 4.1 Type Assertion (`as`)

**Проблема:**
Оператор **type assertion (`as`)** просто **заставляет TypeScript "поверить", что тип корректный**, но **он не делает реальной проверки в рантайме**.

**❌ Плохо — может привести к ошибке:**

```typescript
const input = document.getElementById('myInput') as HTMLInputElement;
console.log(input.value); // ❌ В runtime здесь будет ошибка, если input = null!
```

**Проблема:** Если элемент не найден, `input` будет `null`, но TypeScript об этом не знает!

### 4.2 Type Guards (`typeof`, `instanceof`, `is`)

**Альтернатива – Type Guards делают реальную проверку в рантайме!**

**1. `typeof` – для примитивных типов (`string`, `number`, `boolean`)**

```typescript
const isNumber = (value: unknown): value is number => typeof value === 'number';

const input: unknown = getSomeValue();

if (isNumber(input)) {
  console.log(input.toFixed(2)); // ✅ Теперь TypeScript знает, что это число!
}
```

**Теперь TypeScript проверит тип перед выполнением кода!**

**2. `instanceof` – для классов (`HTMLElement`, `Error`, `Date`)**

```typescript
const input = document.getElementById('myInput');

if (input instanceof HTMLInputElement) {
  console.log(input.value); // ✅ Теперь TypeScript знает, что `input` – это `HTMLInputElement`
} else {
  console.error('Элемент не найден или не является `input`');
}
```

**Теперь `input.value` не вызовет ошибку, если элемент отсутствует!**

**3. Type Guard через функцию `is` (для объектов)**

Допустим, у нас есть **интерфейс `User`**, и нам нужно проверить, что объект соответствует ему.

```typescript
interface User {
  name: string;
  age: number;
}

const isUser = (obj: unknown): obj is User => {
  if (typeof obj !== 'object' || obj === null) return false;

  const user = obj as Record<string, unknown>;

  return typeof user.name === 'string' && typeof user.age === 'number';
};

const data: unknown = { name: 'Alice', age: 25 };

if (isUser(data)) {
  console.log(`Привет, ${data.name}, тебе ${data.age} лет!`);
} else {
  console.error('Некорректный пользователь!');
}
```

**Теперь TypeScript знает, что `data` – это `User`, и мы можем безопасно работать с ним.**

**Ещё примеры Type Guards:**

```typescript
// Для массивов
const isStringArray = (value: unknown): value is string[] =>
  Array.isArray(value) && value.every((item) => typeof item === 'string');

// Для null/undefined
const isDefined = <T>(value: T | null | undefined): value is T =>
  value !== null && value !== undefined;

// Использование
const users: (User | null)[] = getUsers();
const validUsers = users.filter(isDefined); // Type: User[]
```

**Важно помнить:**

- Type assertion (`as`) просто "заставляет поверить" TS, но не проверяет тип реально
- Type guard (как `typeof`, `instanceof`, свои is-функции) реально валидируют тип во время выполнения и защищают от падения приложения

## 5. Константы и Magic Values

### 5.1 Вынос числовых значений

**Правило:** Числа в коде – это магия! Делаем их понятными.

**❌ Плохо — непонятно, что значит `10`:**

```typescript
const users = fetchUsers(10);

const delay = 3600000;
setTimeout(() => {}, 3600000);
```

**✅ Хорошо — `MAX_USERS_PER_PAGE` делает код понятным:**

```typescript
const MAX_USERS_PER_PAGE = 10;
const users = fetchUsers(MAX_USERS_PER_PAGE);

const ONE_HOUR_MS = 60 * 60 * 1000;
setTimeout(() => {}, ONE_HOUR_MS);
```

**Примеры констант:**

```typescript
// Pagination
const ITEMS_PER_PAGE = 20;
const MAX_PAGES = 100;

// Timeouts
const REQUEST_TIMEOUT = 5000;
const DEBOUNCE_DELAY = 300;
const THROTTLE_INTERVAL = 100;

// Limits
const MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
const MIN_PASSWORD_LENGTH = 8;
const MAX_USERNAME_LENGTH = 20;

// Retry
const MAX_RETRY_ATTEMPTS = 3;
const RETRY_DELAY = 1000;
```

### 5.2 Вынос строк в константы

**❌ Плохо — Magic strings:**

```typescript
if (user.role === 'admin') {
}

fetch('/api/users');

localStorage.setItem('token', token);
```

**✅ Хорошо — константы:**

```typescript
const USER_ROLES = {
  ADMIN: 'admin',
  USER: 'user',
  GUEST: 'guest',
} as const;

if (user.role === USER_ROLES.ADMIN) {
}

const API_ENDPOINTS = {
  USERS: '/api/users',
  POSTS: '/api/posts',
} as const;

fetch(API_ENDPOINTS.USERS);

const STORAGE_KEYS = {
  TOKEN: 'token',
  USER: 'user',
} as const;

localStorage.setItem(STORAGE_KEYS.TOKEN, token);
```

### 5.3 Использование `as const` для объектов

```typescript
const ROUTES = {
  HOME: '/',
  OPTIONS: '/options',
  PICKER: '/picker',
} as const;

type Route = (typeof ROUTES)[keyof typeof ROUTES];

// Использование
const navigate = (route: Route) => {
  window.location.hash = route;
};

navigate(ROUTES.PICKER); // ✅
navigate('/unknown'); // ❌ Type error
```

**Преимущества:**

- Централизованное хранилище маршрутов
- Защита от опечаток (автодополнение работает)
- Масштабируемость без дублирования литералов

## Чек-лист: TypeScript Best Practices

### ✅ Типизация

- [ ] Нет `any` в коде
- [ ] Используется `unknown` вместо `any`
- [ ] Нет `{}` или `object` типов
- [ ] Явные типы возврата во всех функциях
- [ ] Type Guards вместо type assertions где возможно

### ✅ Структуры данных

- [ ] `as const` вместо `enum`
- [ ] `type` для простых типов
- [ ] `interface` для расширяемых типов
- [ ] Константы для magic values

### ✅ Настройка

- [ ] Строгий режим в `tsconfig.json`
- [ ] ESLint правила для TypeScript
- [ ] Path aliases настроены
