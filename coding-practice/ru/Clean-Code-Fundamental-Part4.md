# Продвинутые практики чистого кода
## Производительность и тестирование
### 1 Преждевременная оптимизация
> "Premature optimization is the root of all evil" — Donald Knuth

**Правильный подход:**
1. ✅ Сначала **работающий** код
2. ✅ Потом **чистый** код
3. ✅ Профилирование (где реально медленно?)
4. ✅ Оптимизация узких мест
5. ✅ Измерение результата

***
### 1.1 Когда оптимизировать
**Признаки необходимости оптимизации:**
- Измеримая проблема (медленный рендер, долгий запрос)
- Жалобы пользователей
- Метрики показывают проблему
**Профилирование:**
```typescript
// Chrome DevTools Performance
// React DevTools Profiler
// Или вручную
console.time('fetchUsers');
await fetchUsers();
console.timeEnd('fetchUsers'); // fetchUsers: 1234ms
```
**Big O сложность:**
```typescript
// O(n²) — квадратичная (плохо для больших массивов)
for (let i = 0; i < arr.length; i++) {
  for (let j = 0; j < arr.length; j++) {
    // ...
  }
}

// O(n) — линейная (хорошо)
for (let i = 0; i < arr.length; i++) {
  // ...
}

// O(1) — константная (отлично)
const item = map.get(key);
```

***
### 1.2 Простые оптимизации
**Кэширование результатов:**
```typescript
// Мемоизация дорогой функции
const cache = new Map<string, User>();

const getUserById = (id: string): User => {
  if (cache.has(id)) {
    return cache.get(id)!;
  }
  
  const user = database.find(id);
  cache.set(id, user);
  return user;
};
```
**Debounce/Throttle:**
```typescript
// Debounce — вызов после паузы
const debounce = <T extends (...args: unknown[]) => unknown>(
  fn: T,
  delay: number
): ((...args: Parameters<T>) => void) => {
  let timeoutId: NodeJS.Timeout;
  
  return (...args: Parameters<T>) => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => fn(...args), delay);
  };
};

// Использование
const handleSearch = debounce((query: string) => {
  fetchSearchResults(query);
}, 300);

  // Throttle — вызов не чаще N мс
const throttle = <Args extends unknown[], ReturnType>(
  fn: (...args: Args) => ReturnType,
  limit: number
): ((...args: Args) => void) => {
  let inThrottle: boolean;

  return (...args: Args) => {
    if (!inThrottle) {
      fn(...args);
      inThrottle = true;
      setTimeout(() => inThrottle = false, limit);
    }
  };
};

// Использование
const handleScroll = throttle(() => {
  console.log('Scrolling...');
}, 100);
```
**Lazy loading:**
```typescript
// Загрузка по требованию
let heavyModule: typeof import('./heavy-module') | null = null;

const useHeavyFeature = async () => {
  if (!heavyModule) {
    heavyModule = await import('./heavy-module');
  }
  return heavyModule.doSomething();
};
```
**Избегать лишних вычислений:**
```typescript
// ❌ Плохо — вычисляем на каждой итерации
for (let i = 0; i < arr.length; i++) {
  const processedData = expensiveOperation(data); // ❌
  arr[i] = processedData;
}

// ✅ Хорошо — вычисляем один раз
const processedData = expensiveOperation(data);
for (let i = 0; i < arr.length; i++) {
  arr[i] = processedData;
}
```
***
## 2. Тестируемость кода
### 2.1 Что делает код тестируемым
**Чистые функции:**

```typescript
// ✅ Легко тестировать — чистая функция
const add = (a: number, b: number): number => a + b;

test('add', () => {
  expect(add(2, 3)).toBe(5);
});
```
**Dependency Injection:**
```typescript
// ❌ Сложно тестировать — жёсткая зависимость
class UserService {
  private db = new Database(); // ❌

  async getUser(id: string) {
    return this.db.find(id);
  }
}
// ✅ Легко тестировать — DI
class UserService {
  constructor(private db: Database) {} // ✅

  async getUser(id: string) {
    return this.db.find(id);
  }
}
// В тестах используем мок
const mockDb = { find: jest.fn() };
const service = new UserService(mockDb);
```
**Малые функции:**
```typescript
// ✅ Легко тестировать — маленькие функции
const validateEmail = (email: string): boolean =>
  /\S+@\S+\.\S+/.test(email);

const validatePassword = (password: string): boolean =>
  password.length >= 8;

const validateUser = (user: User): boolean =>
  validateEmail(user.email) && validatePassword(user.password);

// Каждую функцию тестируем отдельно
```
**Изоляция side effects:**
```typescript
// ✅ Логика отделена от эффектов
const calculateTotal = (items: Item[]): number =>
  items.reduce((sum, item) => sum + item.price, 0);

const saveOrder = async (order: Order): Promise<void> => {
  const total = calculateTotal(order.items); // Чистая функция
  await database.save({ ...order, total }); // Side effect изолирован
};

// Тестируем calculateTotal без БД
test('calculateTotal', () => {
  expect(calculateTotal([{ price: 10 }, { price: 20 }])).toBe(30);
});
```
***
### 2.2 Признаки нетестируемого кода
**Глобальное состояние:**

```typescript
// ❌ Сложно тестировать
let currentUser: User | null = null;

const getUserName = (): string =>
  currentUser?.name ?? 'Guest'; // Зависит от глобального состояния
```
**Тесно связанный код:**
```typescript
// ❌ Сложно тестировать — всё связано
class OrderProcessor {
  processOrder(order: Order) {
    const validation = new OrderValidator(); // Жёсткая связь
    validation.validate(order);
    
    const payment = new PaymentService(); // Жёсткая связь
    payment.charge(order);
    
    const email = new EmailService(); // Жёсткая связь
    email.send(order.user.email, 'Order confirmed');
  }
}
```
**Скрытые зависимости:**
```typescript
// ❌ Сложно тестировать — скрытая зависимость на Date
const isExpired = (expiryDate: Date): boolean =>
  expiryDate < new Date(); // Зависимость от текущего времени

// ✅ Легко тестировать — явная зависимость
const isExpired = (expiryDate: Date, currentDate: Date = new Date()): boolean =>
  expiryDate < currentDate;

test('isExpired', () => {
  const expiry = new Date('2020-01-01');
  const current = new Date('2021-01-01');
  expect(isExpired(expiry, current)).toBe(true);
});
```
***
### 2.3 Рефакторинг для тестов
**Извлечение зависимостей:**

```typescript
// ❌ До
class UserService {
  async createUser(userData: UserData) {
    const user = new User(userData);
    await database.save(user);
    await emailService.sendWelcome(user.email);
    logger.info(`User created: ${user.id}`);
  }
}

// ✅ После
class UserService {
  constructor(
    private database: Database,
    private emailService: EmailService,
    private logger: Logger
  ) {}

  async createUser(userData: UserData) {
    const user = new User(userData);
    await this.database.save(user);
    await this.emailService.sendWelcome(user.email);
    this.logger.info(`User created: ${user.id}`);
  }
}

// Теперь можно подставить моки в тестах
```
**Разделение логики и эффектов:**
```typescript
// ✅ Чистая логика
const calculateDiscount = (user: User, order: Order): number => {
  if (user.isPremium && order.total > 100) {
    return order.total * 0.2;
  }
  return 0;
};
// ✅ Эффекты отдельно
const applyDiscount = async (user: User, order: Order): Promise<void> => {
  const discount = calculateDiscount(user, order); // Тестируемая логика
  order.discount = discount;
  await database.update(order); // Side effect
};

// Тестируем только логику
test('calculateDiscount', () => {
  const user = { isPremium: true };
  const order = { total: 150 };
  expect(calculateDiscount(user, order)).toBe(30);
});
```
***
