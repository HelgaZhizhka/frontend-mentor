# **1. Основы ООП (Object-Oriented Programming)**

Объектно-ориентированное программирование (ООП) – это подход к проектированию и структурированию кода, основанный на концепции **объектов**, которые содержат данные и методы для работы с ними.
**Ключевые особенности ООП в JavaScript:**
- JavaScript использует **прототипное наследование**, а не классическое
- Классы (`class`) появились в ES6 (2015)
- Всё является объектом (кроме примитивов), и каждый объект имеет внутреннюю ссылку `[[Prototype]]`

---
## **4 Принципа ООП**
### 1. **Инкапсуляция**
**Инкапсуляция** — это защита внутренних данных объекта от прямого доступа извне. Процесс скрытия деталей реализации и показа только функциональности. В JavaScript приватность можно реализовать несколькими способами:
### 1.1. Через приватные поля (`#`)

```tsx
class Person {
  #name; // приватное свойство (ES2022)

  constructor(name) {
    this.#name = name;
  }

  getName() {
    return this.#name;
  }
}

const user = new Person("Olga");
console.log(user.getName()); // "Olga"
console.log(user.#name); // ❌ Ошибка: приватное свойство
```
### 1.2. Через замыкания

```tsx
function createPerson(name) {
  let _name = name; // приватная переменная

  return {
    getName: () => _name
  };
}

const user = createPerson("Olga");
console.log(user.getName()); // "Olga"
console.log(user._name); // ❌ Прямого доступа нет
```
### 1.3. Через `Symbol`

```tsx
const secret = Symbol("secret");

class User {
  constructor(name) {
    this[secret] = name;
  }

  getName() {
    return this[secret];
  }
}

const u = new User("Olya");
console.log(u.getName()); // Olya
console.log(Object.keys(u)); // []
```
### 1.4. Через Getters и Setters
**Getters** и **Setters** позволяют контролировать доступ к свойствам и валидировать данные.

```tsx
class User {
	#age;
	
	constructor(age) {
		this.#age = age;
	}
	
	get age() {
		return this.#age;
	}

	set age(value) {
		if (value < 0 || value > 150) {
			throw new Error("Некорректный возраст");
		}
		this.#age = value;
	}
}

const user = new User(25);
console.log(user.age); // 25 (используем как свойство, а не метод)
user.age = 30; // валидация пройдена
user.age = -5; // ❌ Error: Некорректный возраст
```

> В чём разница между приватностью через # и замыкание?
- `#` — приватность на уровне языка (проверяется рантаймом).
- Замыкание — приватность через область видимости функции.
---
### 2. **Наследование**

**Наследование** позволяет создавать новые классы на основе существующих. JavaScript реализует **прототипное наследование** — каждый объект наследует свойства и методы через цепочку прототипов (`[[Prototype]]`).

```tsx
class Animal {
  constructor(name) {
    [this.name](<http://this.name>) = name;
  }

  speak() {
    console.log(`${[this.name](<http://this.name>)} makes sound`);
  }
}

class Dog extends Animal {
  constructor(name, breed) {
    super(name); // вызов конструктора родителя
    this.breed = breed;
  }

  speak() {
    super.speak(); // доступ к методу родителя
    console.log(`${[this.name](<http://this.name>)} barks`);
  }
}

const dog = new Dog("Rex", "Labrador");
dog.speak();
// Rex makes sound
// Rex barks
```

### Composition vs Inheritance (Композиция против Наследования)
В современной разработке часто предпочитают **композицию** наследованию, так как она более гибкая и избегает проблем глубокой иерархии классов.
**Принцип:** "Предпочитайте композицию наследованию" (Favor composition over inheritance)
**Наследование (жёсткая связь):**

```jsx
class FlyingAnimal extends Animal {
  fly() { console.log("Flying"); }
}

class SwimmingAnimal extends Animal {
  swim() { console.log("Swimming"); }
}

// Проблема: что делать с уткой, которая умеет летать И плавать?
```
**Композиция (гибкость):**

```jsx
const canFly = {
  fly() { console.log(`${[this.name](<http://this.name>)} is flying`); }
};

const canSwim = {
  swim() { console.log(`${[this.name](<http://this.name>)} is swimming`); }
};

const canWalk = {
  walk() { console.log(`${[this.name](<http://this.name>)} is walking`); }
};

// Создаём объект с нужными способностями
function createDuck(name) {
  return Object.assign(
    { name },
    canFly,
    canSwim,
    canWalk
  );
}

const duck = createDuck("Donald");
[duck.fly](<http://duck.fly>)();  // Donald is flying
duck.swim(); // Donald is swimming
duck.walk(); // Donald is walking
```
### 3. **Полиморфизм**
**Полиморфизм** — это способность объектов иметь одинаковый интерфейс, но разное поведение. В JavaScript полиморфизм может быть реализован с помощью переопределения методов.

```tsx
class Animal {
  speak() {
    console.log("Animal makes sound");
  }
}

class Cat extends Animal {
  speak() {
    console.log("Cat meows");
  }
}

class Dog extends Animal {
  speak() {
    console.log("Dog barks");
  }
}

const animals = [new Cat(), new Dog(), new Animal()];
animals.forEach(a => a.speak());

```

В JavaScript также часто используется **утиная типизация**: подход, при котором тип объекта определяется не по его классу, а по его поведению. Если объект имеет нужные методы или свойства, он считается подходящим.

```tsx
function makeSpeak(entity) {
  if (typeof entity.speak === "function") {
    entity.speak();
  }
}

const human = { speak: () => console.log("Hello!") };
makeSpeak(human); // Hello!
```
### 4. **Абстракция**
**Абстракция** — это процесс скрытия деталей реализации и предоставления только необходимого интерфейса.

```tsx
class Car {
  start() {
    this.#fuelInjection();
    console.log("Car starts");
  }

  #fuelInjection() {
    console.log("Fuel feed (hidden logic)");
  }
}

const car = new Car();
car.start(); // Работает
car.#fuelInjection(); // ❌ Ошибка: приватный метод
```
В JavaScript нет абстрактных классов, но их можно имитировать:

```tsx
class Shape {
  constructor() {
    if (new.target === Shape) {
      throw new Error("Shape is abstract and cannot be instantiated directly");
    }
  }

  area() {
    throw new Error("Method 'area()' must be implemented");
  }
}
```
## **Вопросы
1. В чём отличие ООП в JavaScript от Java или C#? JavaScript использует **прототипное наследование**, где объекты наследуют от других объектов. В Java и C# используется **классическое наследование**, где наследование идёт от классов.
2. Чем отличаются `#private` поля от замыканий? `#private` обеспечивает приватность на уровне языка и работает только в классах. Замыкания создают приватность через область видимости функции и могут использоваться вне классов.
3. Что такое утиная типизация? **Ответ:** утиная типизация (duck typing) — это принцип «если объект выглядит как утка и крякает как утка — значит, это утка». В JavaScript он позволяет использовать объекты без строгого наследования, если они реализуют нужное поведение.
4. Как имитировать абстрактные классы в JavaScript? Можно выбрасывать ошибку при попытке создать экземпляр базового класса (`if (new.target === Base)`), а также требовать реализацию методов через `throw new Error('must be implemented')`.
5. **Когда использовать композицию вместо наследования?**
    Когда нужна гибкость в комбинировании поведения (например, объект может летать И плавать), когда иерархия наследования становится слишком глубокой или когда нужно избежать жёсткой связи между классами.
---
## **Практическое задание**
**Задача 1:** реализовать класс `Storage`, в котором данные защищены и доступны только через методы.

```tsx
class Storage {
  #items = [];

  add(item) {
    this.#items.push(item);
  }

  getAll() {
    return [...this.#items];
  }
}

const store = new Storage();
store.add("apple");
console.log(store.getAll()); // ['apple']
console.log(store.#items); // ❌ Ошибка доступа
```

**Задача 2:** Создать систему животных с использованием композиции.
```tsx
// Способности
const canFly = {
	fly() { return `${[this.name](<http://this.name>)} is flying`; }
};

const canSwim = {
	swim() { return `${[this.name](<http://this.name>)} is swimming`; }
};

const canWalk = {
	walk() { return `${[this.name](<http://this.name>)} is walking`; }
};

// Фабрики
function createBird(name) {
	return Object.assign({ name }, canFly, canWalk);
}

function createFish(name) {
	return Object.assign({ name }, canSwim);
}

function createDuck(name) {
	return Object.assign({ name }, canFly, canSwim, canWalk);
}

// Использование
const sparrow = createBird("Sparrow");
const salmon = createFish("Salmon");
const duck = createDuck("Donald");
console.log([sparrow.fly](<http://sparrow.fly>)());  // Sparrow is flying
console.log(salmon.swim());  // Salmon is swimming
console.log([duck.fly](<http://duck.fly>)());     // Donald is flying
console.log(duck.swim());    // Donald is swimming
console.log(duck.walk());    // Donald is walking
```
**Задача 3 (со звёздочкой ):** Реализовать класс `BankAccount`, применяя все 4 принципа ООП**. Требования:
- Инкапсуляция: приватный баланс и история транзакций
- Наследование: создать `SavingsAccount` с дополнительными методами
- Полиморфизм: переопределить метод `withdraw` с комиссией
- Абстракция: скрыть логику валидации в приватных методах

```tsx
class BankAccount {
	#balance = 0;
	#transactionHistory = [];
	
	constructor(initialBalance = 0) {
		this.#validateAmount(initialBalance, "начальный баланс");
		this.#balance = initialBalance;
	}
	// Абстракция: скрытая логика валидации
	#validateAmount(amount, operation) {
		if (amount < 0) {
			throw new Error(`${operation} не может быть отрицательным`);
		}
		if (amount === 0) {
			throw new Error(`${operation} должен быть больше нуля`);
		}
	}

	#addTransaction(type, amount) {
		this.#transactionHistory.push({
			type,
			amount,
			balance: this.#balance,
			date: new Date().toISOString()
		});
	}

	// Инкапсуляция: getter для доступа к балансу
	get balance() {
		return this.#balance;
	}
	
	deposit(amount) {
		this.#validateAmount(amount, "Сумма пополнения");
		this.#balance += amount;
		this.#addTransaction("deposit", amount);
		return this.#balance;
	}

	withdraw(amount) {
		this.#validateAmount(amount, "Сумма снятия");
		if (amount > this.#balance) {
			throw new Error("Недостаточно средств");
		}
		this.#balance -= amount;
		this.#addTransaction("withdraw", amount);
		return this.#balance;
	}

	getHistory() {
	return [...this.#transactionHistory]; // возвращаем копию
	}
}

// Наследование: сберегательный счёт с процентами
class SavingsAccount extends BankAccount {
	#interestRate;
	constructor(initialBalance, interestRate = 0.05) {
		super(initialBalance);
		this.#interestRate = interestRate;
	}
	// Полиморфизм: переопределение метода
	withdraw(amount) {
		const fee = amount * 0.01; // 1% комиссия
		return super.withdraw(amount + fee);
	}
	addInterest() {
		const interest = this.balance * this.#interestRate;
		this.deposit(interest);
		return interest;
	}
}

// Использование
const account = new BankAccount(1000);
account.deposit(500);
account.withdraw(200);
console.log(account.balance); // 1300
console.log(account.getHistory());
const savings = new SavingsAccount(5000, 0.05);
savings.deposit(1000);
savings.addInterest(); // +5% к балансу
savings.withdraw(100); // с комиссией 1%
console.log(savings.balance);
```

Что демонстрирует эта задача: Инкапсуляция: `#balance`, `#transactionHistory`, `#validateAmount` — приватные  
Наследование: `SavingsAccount extends BankAccount` Полиморфизм: `withdraw()` работает по-разному в разных классах  
Абстракция: логика валидации скрыта в `#validateAmount`
## **Итог**

ООП в JavaScript базируется на прототипах, но с современным синтаксисом `class` принципы **инкапсуляции**, **наследования**, **полиморфизма** и **абстракции** реализуются так же удобно, как в классических языках.
## **Материалы для изучения**
[https://github.com/rolling-scopes-school/tasks/tree/master/stage1/modules/oop-basics](https://github.com/rolling-scopes-school/tasks/tree/master/stage1/modules/oop-basics) - тема в **RS School**
**Книги:**
- JavaScript. Подробное руководство (David Flanagan) — главы об объектах и классах
- Learning JavaScript Design Patterns (Addy Osmani) — паттерны ООП
- Effective TypeScript (Dan Vanderkam) — ООП в TypeScript
**Ссылки**:
- [MDN: Classes](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes)
- [MDN: Inheritance and the prototype chain](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Inheritance_and_the_prototype_chain)
- [JavaScript.info](http://JavaScript.info)[: Prototypes](https://javascript.info/prototypes)
- [JavaScript.info](http://JavaScript.info)[: Classes](https://javascript.info/classes)