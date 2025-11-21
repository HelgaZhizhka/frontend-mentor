# Clean Code Fundamentals
**Clean code** is code that is easy to read, understand, and maintain. It is written so that another developer (or you in six months) can quickly figure out what's happening and make changes without fear of breaking something.

## Why Clean Code Matters?
- **Reduces maintenance costs** — less time to understand "what the hell does this do"
- **Simplifies adding new features** — clear structure = fast development
- **Decreases the number of bugs** — explicit code = fewer surprises
- **Improves team collaboration** — everyone understands each other's code
- **Simplifies code review** — no need to spend hours deciphering
### The Cost of Bad Code
```javascript
// ❌ Bad code
function calc(a, b, t) {
  if (t == 1) return a + b;
  if (t == 2) return a - b;
  if (t == 3) return a * b;
  return a / b;
}
```
**Problems:**
- Unclear names (`a`, `b`, `t`)
- Magic numbers (what do `1`, `2`, `3` mean?)
- Weak comparison (`==` instead of `===`)
- No division by zero handling

```javascript
// ✅ Clean code
const OPERATIONS = {
  ADD: 'add',
  SUBTRACT: 'subtract',
  MULTIPLY: 'multiply',
  DIVIDE: 'divide',
} as const;

function calculate(
  firstNumber: number,
  secondNumber: number,
  operation: keyof typeof OPERATIONS
): number {
  switch (operation) {
    case OPERATIONS.ADD:
      return firstNumber + secondNumber;
    case OPERATIONS.SUBTRACT:
      return firstNumber - secondNumber;
    case OPERATIONS.MULTIPLY:
      return firstNumber * secondNumber;
    case OPERATIONS.DIVIDE:
      if (secondNumber === 0) {
        throw new Error('Division by zero is impossible');
      }
      return firstNumber / secondNumber;
    default:
      throw new Error(`Unknown operation: ${operation}`);
  }
}
```

## 1. Naming Conventions
### 1.1 General Principles
**Good naming rules:**
1. **Clarity over brevity** — `userAge` is better than `ua`
2. **Avoid abbreviations** — `button` is better than `btn` (except commonly accepted ones: `id`, `url`, `api`)
3. **Context matters** — `name` in `User` context makes sense, but `n` does not
4. **Avoid disinformation** — `userList` should be an array, not an object

**❌ Bad:**
```typescript
const d = new Date(); // ❌ What is d?
const temp = getData(); // ❌ Vague temporary variable
const data = fetchUsers(); // ❌ Too generic
```
**✅ Good:**
```typescript
const currentDate = new Date();
const userResponse = getData();
const users = fetchUsers();
```
***
### 1.2 Variables
**Rules:**
- **camelCase** for regular variables
- **UPPER_SNAKE_CASE** for constants
- **Nouns** for data
- **Plural** for arrays

**❌ Bad:**
```typescript
const d = 5; // ❌ Unclear what this is
const UserName = 'John'; // ❌ Variable should not start with capital letter
const user = ['John', 'Jane', 'Bob']; // ❌ Name is singular, but data is array
const maxage = 100; // ❌ Unclear if this is a constant
```
**✅ Good:**
```typescript
const daysInWeek = 7;
const userName = 'John';
const users = ['John', 'Jane', 'Bob'];
const MAX_AGE = 100;
const API_ENDPOINT = 'https://api.example.com';
```
**Contextual names:**
```typescript
// ❌ Bad — unclear from context
const process = (n: string): string => n.toUpperCase();

// ✅ Good — context is clear
const formatUserName = (userName: string): string => userName.toUpperCase();
```
***
### 1.3 Functions
**Rules:**
- **camelCase**
- **Verbs** for actions
- **get/set/is/has/should** prefixes
- **Name reflects WHAT the function does**

**Typical prefixes:**

| Prefix | Meaning | Example |
|--------|---------|---------|
| `get` | Get data | `getUser()`, `getUserName()` |
| `set` | Set a value | `setUser()`, `setUserName()` |
| `is` | Boolean check | `isActive()`, `isValid()` |
| `has` | Has something | `hasPermission()`, `hasAccess()` |
| `should` | Condition | `shouldUpdate()`, `shouldRender()` |
| `create` | Create | `createUser()`, `createOrder()` |
| `update` | Update | `updateUser()`, `updateProfile()` |
| `delete` | Delete | `deleteUser()`, `deleteOrder()` |
| `fetch` | Load data (async) | `fetchUsers()`, `fetchPosts()` |
| `handle` | Handle event | `handleClick()`, `handleSubmit()` |
| `calculate` | Calculate | `calculateTotal()`, `calculateTax()` |
| `validate` | Validate | `validateEmail()`, `validateForm()` |
| `format` | Format | `formatDate()`, `formatCurrency()` |

**❌ Bad:**
```typescript
const data = () => { /*...*/ }; // ❌ Not a verb
const process = () => { /*...*/ }; // ❌ Too generic
const doStuff = () => { /*...*/ }; // ❌ Unclear what it does
const x = (a, b) => { /*...*/ }; // ❌ Unreadable
```
**✅ Good:**
```typescript
const getUserById = (id: string): User => { /*...*/ };
const calculateTotalPrice = (items: Item[]): number => { /*...*/ };
const isUserActive = (user: User): boolean => { /*...*/ };
const hasAdminPermission = (user: User): boolean => { /*...*/ };
const shouldRenderHeader = (): boolean => { /*...*/ };
```
**One function — one action:**
```typescript
// ❌ Bad — function does too much
const processUserAndSendEmail = (user: User) => {
  validateUser(user);
  saveUser(user);
  sendWelcomeEmail(user);
  logActivity(user);
};

// ✅ Good — each function does one thing
const validateUser = (user: User): boolean => { /*...*/ };
const saveUser = (user: User): void => { /*...*/ };
const sendWelcomeEmail = (user: User): void => { /*...*/ };
const logUserActivity = (user: User): void => { /*...*/ };

const onboardNewUser = (user: User): void => {
  if (!validateUser(user)) return;
  saveUser(user);
  sendWelcomeEmail(user);
  logUserActivity(user);
};
```
***
### 1.4 Classes and Components
**Rules:**
- **PascalCase**
- **Nouns**
- **Descriptive names**
- **Avoid Manager, Helper, Utils suffixes** (when possible)

**❌ Bad:**
```typescript
class user { } // ❌ Starts with lowercase letter
class UserManager { } // ❌ Too generic suffix
class UserUtils { } // ❌ "Utils" indicates poor abstraction
class DataHandler { } // ❌ Unclear what it handles
```
**✅ Good:**
```typescript
class User { }
class UserRepository { } // Specific responsibility
class UserValidator { }
class EmailService { }
class PaymentProcessor { }

// React components
const UserProfile = () => { };
const ProductCard = () => { };
const NavigationMenu = () => { };
```
**When Manager/Helper are acceptable:**
- `CacheManager` — manages cache
- `ConfigurationManager` — manages configuration
- `StringHelper` — utility functions for strings (but better to move separate functions)

***
### 1.5 Boolean Variables
**Rules:**
- **is/has/should/can** prefixes
- **Affirmative form**
- **Clear question**

**❌ Bad:**
```typescript
const active = true; // ❌ Not clear it's boolean
const notDisabled = false; // ❌ Double negative
const flag = true; // ❌ Unclear what flag
```
**✅ Good:**
```typescript
const isActive = true;
const isDisabled = false;
const hasPermission = true;
const shouldUpdate = false;
const canDelete = true;
const isLoading = false;
const hasErrors = true;
```
**Examples in context:**
```typescript
// User
const isUserLoggedIn = true;
const hasUserVerifiedEmail = false;
const isUserAdmin = true;

// Form
const isFormValid = true;
const hasFormErrors = false;
const shouldShowErrors = true;

// UI
const isModalOpen = false;
const shouldRenderHeader = true;
const canSubmitForm = true;
```
***
### 1.6 Naming Anti-patterns
**Avoid:**

| Bad | Why bad | Good |
|-----|----------|------|
| `temp` | Unclear what is temporary | `currentUser`, `cachedData` |
| `data` | Too generic | `users`, `products`, `orders` |
| `info` | Not informative | `userDetails`, `orderSummary` |
| `obj` | Unclear what object | `user`, `product`, `order` |
| `arr` | Unclear what's in array | `users`, `items`, `products` |
| `flag` | Unclear what flag | `isActive`, `shouldUpdate` |
| `x`, `y`, `z` | Single-letter (except loops) | Full name |
| `userObj` | Hungarian notation | `user` (type is visible anyway) |
| `strName` | Hungarian notation | `userName` |

**Exceptions:**
- `i`, `j`, `k` — in short loops
- `e` — for event in handlers
- `_` — for unused parameters
```typescript
// ✅ Acceptable
for (let i = 0; i < items.length; i++) { }

array.forEach((_, index) => { }); // Not using element

button.addEventListener('click', (e) => {
  e.preventDefault();
});
```
***
## 2. Functions and Methods
### 2.1 Function Size
**Rule:** A function should do ONE action.
**Optimal size:**
- **5-15 lines** — ideal
- **20-30 lines** — acceptable
- **More than 30** — consider splitting

**❌ Bad — function does too much:**
```typescript
const processOrder = (order: Order) => {
  // Validation (5 lines)
  if (!order.items.length) throw new Error('Empty order');
  if (!order.user) throw new Error('No user');
  if (!order.address) throw new Error('No address');

  // Calculation (10 lines)
  let total = 0;
  order.items.forEach(item => {
    const discount = item.hasDiscount ? item.price * 0.1 : 0;
    const tax = (item.price - discount) * 0.2;
    total += item.price - discount + tax;
  });

  // Email sending (5 lines)
  const emailBody = `Thank you for your order! Total: ${total}`;
  sendEmail(order.user.email, emailBody);

  // Database saving (5 lines)
  database.save({
    userId: order.user.id,
    total,
    date: new Date()
  });

  // Logging (3 lines)
  logger.log(`Order processed for ${order.user.name}`);

  return total;
};
```
**✅ Good — split into small functions:**
```typescript
const validateOrder = (order: Order): void => {
  if (!order.items?.length) throw new Error('Order must contain items');
  if (!order.user) throw new Error('Order must have a user');
  if (!order.address) throw new Error('Order must have a shipping address');
};

const calculateItemPrice = (item: OrderItem): number => {
  const discount = item.hasDiscount ? item.price * 0.1 : 0;
  const priceAfterDiscount = item.price - discount;
  const tax = priceAfterDiscount * 0.2;
  return priceAfterDiscount + tax;
};

const calculateOrderTotal = (items: OrderItem[]): number =>
  items.reduce((total, item) => total + calculateItemPrice(item), 0);

const sendOrderConfirmation = (user: User, total: number): void => {
  const emailBody = `Thank you for your order! Total: $${total}`;
  sendEmail(user.email, emailBody);
};

const saveOrderToDatabase = (order: Order, total: number): void => {
  database.save({
    userId: order.user.id,
    total,
    date: new Date()
  });
};

const logOrderProcessed = (user: User): void => {
  logger.log(`Order processed for ${user.name}`);
};

// Main function — orchestrator
const processOrder = (order: Order): number => {
  validateOrder(order);

  const total = calculateOrderTotal(order.items);

  sendOrderConfirmation(order.user, total);
  saveOrderToDatabase(order, total);
  logOrderProcessed(order.user);

  return total;
};
```
**When to split a function:**
- Visible **logical blocks** (validation, calculation, saving)
- There are **comments** like "// Validate", "// Calculate" — each block -> separate function
- Function does more than one thing
- Hard to understand at first glance

***
### 2.2 Function Parameters
**Rule:**
- **0-2 parameters** — ideal
- **3 parameters** — acceptable
- **More than 3** — use parameter object

**❌ Bad — too many parameters:**
```typescript
const createUser = (
  firstName: string,
  lastName: string,
  email: string,
  age: number,
  address: string,
  phone: string,
  role: string
) => {
  // ...
};

// Usage — easy to make mistakes in order
createUser('John', 'Doe', 'john@example.com', 30, '123 St', '+123456', 'admin');
```
**✅ Good — parameter object:**
```typescript
interface CreateUserParams {
  firstName: string;
  lastName: string;
  email: string;
  age: number;
  address: string;
  phone: string;
  role: string;
}

const createUser = (params: CreateUserParams): User => {
  // Destructuring for convenience
  const { firstName, lastName, email, age, address, phone, role } = params;
  // ...
};

// Usage — clear and safe
createUser({
  firstName: 'John',
  lastName: 'Doe',
  email: 'john@example.com',
  age: 30,
  address: '123 St',
  phone: '+123456',
  role: 'admin'
});
```
**Avoid boolean flags:**
```typescript
// ❌ Bad
const renderPage = (showHeader: boolean, showFooter: boolean, showSidebar: boolean) => {
  if (showHeader) { /* ... */ }
  if (showFooter) { /* ... */ }
  if (showSidebar) { /* ... */ }
};

renderPage(true, false, true); // ❌ Unclear what these flags mean

// ✅ Good — object with named fields
interface PageLayout {
  showHeader: boolean;
  showFooter: boolean;
  showSidebar: boolean;
}

const renderPage = (layout: PageLayout) => {
  if (layout.showHeader) { /* ... */ }
  if (layout.showFooter) { /* ... */ }
  if (layout.showSidebar) { /* ... */ }
};

renderPage({
  showHeader: true,
  showFooter: false,
  showSidebar: true
}); // ✅ Everything is clear
```
**Parameter destructuring:**
```typescript
// ✅ Good practice
const createUser = ({ firstName, lastName, email }: CreateUserParams): User => ({
  id: generateId(),
  firstName,
  lastName,
  email,
  createdAt: new Date()
});
```
***
### 2.3 Side Effects (Side Effects)
**Definition:** A side effect is any change to state outside the function (mutating variables, writing to DB, console.log, DOM changes).

**Pure Functions (Pure Functions):**
- No side effects
- Always return the same result for same inputs
- Easy to test

**❌ Bad — hidden side effects:**
```typescript
let totalPrice = 0; // Global variable

const addItemPrice = (price: number) => {
  totalPrice += price; // ❌ Global state mutation
  console.log('Added:', price); // ❌ Side effect
  return totalPrice;
};

addItemPrice(10); // totalPrice = 10
addItemPrice(20); // totalPrice = 30 — function depends on global state!
```
**✅ Good — pure function:**
```typescript
const addItemPrice = (currentTotal: number, price: number): number =>
  currentTotal + price; // ✅ No side effects

let totalPrice = 0;
totalPrice = addItemPrice(totalPrice, 10); // 10
totalPrice = addItemPrice(totalPrice, 20); // 30
```
**When side effects are inevitable:**
```typescript
// Side effects indicated by name
const saveUserToDatabase = async (user: User): Promise<void> => {
  await database.save(user); // ❌ Side effect, but explicit
};

const logError = (message: string): void => {
  console.error(message); // ❌ Side effect, but explicit
};

const sendEmail = (to: string, body: string): void => {
  emailService.send(to, body); // ❌ Side effect, but explicit
};
```
**How to isolate side effects:**
1. **Put in separate functions** with explicit names
2. **Separate "computation" and "action"**
3. **Make business logic** pure functions

```typescript
// ✅ Separation: pure function + side effect function
const calculateTotal = (items: Item[]): number =>
  items.reduce((sum, item) => sum + item.price, 0);

const saveOrder = async (order: Order): Promise<void> => {
  const total = calculateTotal(order.items); // Pure function
  await database.save({ ...order, total }); // Side effect isolated
};
```
***
### 2.4 Single Responsibility for Functions
**Rule:** Each function should do one thing and do it well.

**❌ Bad — function does multiple things:**
```typescript
const processUserData = (userId: string) => {
  // 1. Loading
  const user = database.getUser(userId);

  // 2. Validation
  if (!user.email) throw new Error('No email');

  // 3. Calculation
  const age = calculateAge(user.birthDate);

  // 4. Formatting
  const formatted = `${user.firstName} ${user.lastName}, ${age} years old`;

  // 5. Saving
  cache.set(userId, formatted);

  // 6. Return
  return formatted;
};
```
**✅ Good — each function does one thing:**
```typescript
const getUserById = (userId: string): User =>
  database.getUser(userId);

const validateUserEmail = (user: User): void => {
  if (!user.email) {
    throw new Error('User must have an email');
  }
};

const calculateUserAge = (birthDate: Date): number => {
  const today = new Date();
  return today.getFullYear() - birthDate.getFullYear();
};

const formatUserInfo = (user: User, age: number): string =>
  `${user.firstName} ${user.lastName}, ${age} years old`;

const cacheUserInfo = (userId: string, info: string): void => {
  cache.set(userId, info);
};

// Orchestrator
const processUserData = (userId: string): string => {
  const user = getUserById(userId);
  validateUserEmail(user);

  const age = calculateUserAge(user.birthDate);
  const formatted = formatUserInfo(user, age);

  cacheUserInfo(userId, formatted);

  return formatted;
};
```
***
### 2.5 Return Values
**Early Return Pattern**

**❌ Bad — deep nesting:**
```typescript
const getDiscount = (user: User): number => {
  if (user) {
    if (user.isPremium) {
      if (user.orders > 10) {
        return 0.2;
      } else {
        return 0.1;
      }
    } else {
      return 0.05;
    }
  } else {
    return 0;
  }
};
```
**✅ Good — early return:**
```typescript
const getDiscount = (user: User | null): number => {
  if (!user) return 0;
  if (!user.isPremium) return 0.05;
  if (user.orders > 10) return 0.2;
  return 0.1;
};
```
**Guard Clauses**
```typescript
const processPayment = (amount: number, user: User): void => {
  // Guard clauses at the beginning
  if (amount <= 0) {
    throw new Error('Amount must be positive');
  }

  if (!user) {
    throw new Error('User is required');
  }

  if (!user.paymentMethod) {
    throw new Error('Payment method is required');
  }

  // Main logic only when everything is OK
  chargeUser(user, amount);
};
```
**One return type:**
```typescript
// ❌ Bad — mixed return types
const getUser = (id: string): User | null | undefined | false => {
  if (!id) return false; // ❌
  if (id === 'invalid') return undefined; // ❌
  const user = database.find(id);
  return user || null; // ❌
};

// ✅ Good — one return type
const getUser = (id: string): User | null => {
  if (!id) return null;
  if (id === 'invalid') return null;
  return database.find(id) || null;
};
```
***
### 2.6 Arrow vs Regular Functions
**When to use arrow functions:**

✅ **Callbacks:**
```typescript
const numbers = [1, 2, 3, 4];

// ✅ Good
const doubled = numbers.map(n => n * 2);
const evens = numbers.filter(n => n % 2 === 0);
```

✅ **Short functions:**
```typescript
const add = (a: number, b: number) => a + b;
const isEven = (n: number) => n % 2 === 0;
```

✅ **Methods in React:**
```typescript
const Component = () => {
  // ✅ No need to bind this
  const handleClick = () => {
    console.log('Clicked');
  };

  return <button onClick={handleClick}>Click</button>;
};
```

**When to use regular functions:**

❌ **Object methods (if `this` needed):**
```typescript
const user = {
  name: 'John',
  greet: function() {
    console.log(`Hello, ${this.name}`); // ✅ this works
  }
};

const userArrow = {
  name: 'John',
  greet: () => {
    console.log(`Hello, ${this.name}`); // ❌ this doesn't work
  }
};
```

✅ **Constructors:**
```typescript
function Person(name: string) {
  this.name = name;
}

// ❌ Arrow functions cannot be constructors
const PersonArrow = (name: string) => {
  this.name = name; // Error!
};
```

***
## 3. Comments and Documentation
### 3.1 When Comments Are NOT Needed
**Self-documenting code:**
```typescript
// ❌ Bad — comment describes the obvious
// Increment counter
counter++;

// ❌ Bad — comment duplicates code
// Check if user is active
if (user.isActive) { }

// ❌ Bad — comment instead of proper name
// Days in a week
const d = 7;

// ✅ Good — code speaks for itself
const DAYS_IN_WEEK = 7;

if (user.isActive) {
  activateUserAccount(user);
}
```

**Remove commented code!**
```typescript
// ❌ Bad
const calculateTotal = (items) => {
  // const tax = 0.1;
  // const discount = 0.05;
  return items.reduce((sum, item) => sum + item.price, 0);
  // return total * (1 + tax) * (1 - discount);
};

// ✅ Good — no commented code
const calculateTotal = (items: Item[]): number =>
  items.reduce((sum, item) => sum + item.price, 0);
```

***
### 3.2 When Comments Are Useful
**1. Complex business logic:**
```typescript
// ✅ Good — explain "why"
const calculateShippingCost = (order: Order): number => {
  const baseRate = 10;

  // Apply 20% discount for orders over $100 according to Q4 2024 marketing campaign
  if (order.total > 100) {
    return baseRate * 0.8;
  }

  return baseRate;
};
```

**2. Non-obvious solutions:**
```typescript
// ✅ Explain why this solution was chosen
const debounce = (fn: Function, delay: number) => {
  let timeoutId: NodeJS.Timeout;

  return (...args: unknown[]) => {
    // Clear previous timer instead of checking time
    // because clearTimeout is more memory efficient
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => fn(...args), delay);
  };
};
```

**3. Workarounds and hacks:**
```typescript
// ✅ Explain temporary solution
const parseDate = (dateString: string): Date => {
  // FIXME: Safari doesn't support ISO format with timezone,
  // temporarily use date-fns library
  // Remove after updating minimum Safari version to 16+
  return parse(dateString, 'yyyy-MM-dd', new Date());
};
```

**4. Warnings:**
```typescript
// ✅ Warn about important details
const deleteUser = (userId: string): Promise<void> => {
  // IMPORTANT: This operation is irreversible!
  // All related data (orders, comments) will also be deleted
  return database.delete('users', userId);
};
```

***
### 3.3 JSDoc
**When to use:**
- Public API
- Libraries and packages
- Complex functions

```typescript
/**
 * Calculates the final order total including taxes and discounts
 *
 * @param items - Array of order items
 * @param taxRate - Tax rate (0 to 1)
 * @param discount - Discount percentage (0 to 100)
 * @returns Final order total
 *
 * @example
 * const total = calculateOrderTotal(
 *   [{ price: 100 }, { price: 200 }],
 *   0.2,
 *   10
 * ); // 270
 *
 * @throws {Error} If item array is empty
 */
const calculateOrderTotal = (
  items: Item[],
  taxRate: number,
  discount: number
): number => {
  if (items.length === 0) {
    throw new Error('Order must contain at least one item');
  }

  const subtotal = items.reduce((sum, item) => sum + item.price, 0);
  const discountAmount = subtotal * (discount / 100);
  const taxAmount = (subtotal - discountAmount) * taxRate;

  return subtotal - discountAmount + taxAmount;
};
```

**Main JSDoc tags:**

| Tag | Description |
|-----|-------------|
| `@param` | Function parameters |
| `@returns` | What it returns |
| `@throws` | Errors it can throw |
| `@example` | Usage example |
| `@deprecated` | Deprecated method |
| `@see` | Link to related code |

***
### 3.4 TODO/FIXME
```typescript
// TODO: Add email validation (Olga, 2024-11-20)
const saveUser = (user: User) => {
  database.save(user);
};

// FIXME: Memory leak when component unmounts (high priority)
useEffect(() => {
  const interval = setInterval(() => {
    fetchData();
  }, 1000);

  // Need to add cleanup
}, []);

// HACK: Temporary solution until API update
const getUsers = async () => {
  // Add delay because API sometimes returns cache
  await delay(100);
  return fetch('/api/users');
};

// NOTE: Do not use in production, only for debugging
const DEBUG_MODE = true;
```

**Format:**
```
// TODO: What to do (Author, Date)
// FIXME: What is broken (priority)
// HACK: Why the hack, when to remove
// NOTE: Important information
```

***
### 3.5 Comments "Why", Not "What"
**❌ Bad — comment describes WHAT the code does:**

```typescript
// Check if user is active
if (user.isActive) {
  // Send email
  sendEmail(user.email);
}
```

**✅ Good — comment explains WHY:**
```typescript
// Send email only to active users,
// because inactive ones may have unsubscribed from mailing
if (user.isActive) {
  sendEmail(user.email);
}
```

**✅ Even better — code explains itself:**
```typescript
const shouldSendEmail = (user: User): boolean => {
  // Inactive users unsubscribed from mailing
  return user.isActive;
};

if (shouldSendEmail(user)) {
  sendEmail(user.email);
}
```

***
## 4. Error Handling
### 4.1 Try-Catch Rules

**❌ Bad — ignoring errors:**
```typescript
try {
  const data = JSON.parse(jsonString);
} catch (error) {
  // ❌ Swallowed error
}
```

**✅ Good — error handling:**
```typescript
try {
  const data = JSON.parse(jsonString);
  return data;
} catch (error) {
  console.error('Failed to parse JSON:', error);
  throw new Error('Invalid JSON format');
}
```

**Specific catch blocks:**
```typescript
try {
  await saveUser(user);
} catch (error) {
  if (error instanceof ValidationError) {
    showValidationErrors(error.fields);
  } else if (error instanceof NetworkError) {
    showNetworkErrorMessage();
  } else {
    showGenericErrorMessage();
    logError(error);
  }
}
```

**Finally for cleanup:**
```typescript
let connection;

try {
  connection = await database.connect();
  await connection.query('SELECT * FROM users');
} catch (error) {
  console.error('Database error:', error);
} finally {
  // ✅ Cleanup always executes
  if (connection) {
    await connection.close();
  }
}
```

**❌ Do not use as flow control:**
```typescript
// ❌ Bad — try-catch for flow control
try {
  const user = getUser(userId);
  return user;
} catch (error) {
  return null; // ❌ Errors not for logic
}

// ✅ Good — explicit check
const getUser = (userId: string): User | null => {
  if (!userId) return null;
  return database.find(userId) || null;
};
```

***
### 4.2 Fail Fast Principle
**Check at the beginning:**
```typescript
const calculateDiscount = (price: number, discountPercent: number): number => {
  // ✅ Fail Fast — checks at the beginning
  if (price < 0) {
    throw new Error('Price cannot be negative');
  }

  if (discountPercent < 0 || discountPercent > 100) {
    throw new Error('Discount must be between 0 and 100');
  }

  return price * (discountPercent / 100);
};
```

**Early return on error:**
```typescript
const processPayment = (order: Order): PaymentResult => {
  // ✅ Early exits on problems
  if (!order.items.length) {
    return { success: false, error: 'Order is empty' };
  }

  if (!order.paymentMethod) {
    return { success: false, error: 'Payment method required' };
  }

  if (order.total <= 0) {
    return { success: false, error: 'Invalid order total' };
  }

  // Main logic only when everything is OK
  const result = chargePayment(order);
  return result;
};
```

**Guard clauses:**
```typescript
const sendEmail = (email: string, subject: string, body: string): void => {
  // Guard clauses
  if (!email) throw new Error('Email is required');
  if (!isValidEmail(email)) throw new Error('Invalid email format');
  if (!subject) throw new Error('Subject is required');
  if (!body) throw new Error('Body is required');

  // Main logic
  emailService.send({ email, subject, body });
};
```

***
### 4.3 Defensive Programming
**Null/undefined checks:**
```typescript
// ❌ Bad — may crash
const getUserName = (user: User) => {
  return user.profile.firstName; // ❌ If profile = null?
};

// ✅ Good — null protection
const getUserName = (user: User | null): string => {
  if (!user) return 'Anonymous';
  if (!user.profile) return 'No profile';
  return user.profile.firstName || 'Unknown';
};

// ✅ Even better — optional chaining
const getUserName = (user: User | null): string =>
  user?.profile?.firstName ?? 'Anonymous';
```

**Type validation:**
```typescript
const calculateTotal = (items: unknown): number => {
  // ✅ Check type
  if (!Array.isArray(items)) {
    throw new Error('Items must be an array');
  }

  return items.reduce((sum: number, item: unknown) => {
    if (typeof item.price !== 'number') {
      throw new Error('Item price must be a number');
    }
    return sum + item.price;
  }, 0);
};
```

**Edge cases:**
```typescript
const divide = (a: number, b: number): number => {
  // ✅ Check edge case
  if (b === 0) {
    throw new Error('Division by zero');
  }

  // ✅ Check NaN
  if (isNaN(a) || isNaN(b)) {
    throw new Error('Arguments must be numbers');
  }

  return a / b;
};
```

**Optional chaining (?.) and Nullish coalescing (??):**
```typescript
// ❌ Bad — long check
const city = user && user.address && user.address.city ? user.address.city : 'Unknown';

// ✅ Good — optional chaining + nullish coalescing
const city = user?.address?.city ?? 'Unknown';

// ✅ With default value
const age = user?.age ?? 18;

// ✅ With method call
const userName = user?.getName?.() ?? 'Guest';
```
