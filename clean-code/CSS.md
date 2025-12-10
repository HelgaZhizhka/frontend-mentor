# CSS Best Practices

## 1. Динамические стили через классы

### 1.1 Почему не через JavaScript?

**Проблемы inline стилей через JS:**

- Смешивание **логики и представления**
- Сложно **переопределить** (inline стили имеют высокий приоритет)
- Плохая **производительность** (каждое изменение - reflow)
- Сложно **поддерживать** (стили разбросаны по JS файлам)
- Не работает **CSS transitions/animations**

### 1.2 Когда JS стили допустимы?

**Используй inline стили ТОЛЬКО для:**

- Динамических значений (координаты мыши, прогресс бар)
- Значений от пользователя (цвет, размер)
- Значений из API (позиционирование карты)

## 2. Вложенность селекторов

### 2.1 Почему вложенность ≤2 уровня?

**Проблемы глубокой вложенности:**

- Высокая **специфичность** (сложно переопределить)
- Плохая **производительность** (браузер вычисляет медленнее)
- Хрупкий код (изменение HTML ломает стили)
- Сложно **переиспользовать**

**Плохо (глубокая вложенность):**

```css
/* Специфичность: 0,0,4,0 - слишком высокая! */
.container .sidebar .menu .item a {
  color: blue;
}

/* 5 уровней вложенности! */
header nav ul li a span {
  font-weight: bold;
}
```

**✅ Хорошо (≤2 уровня):**

```css
/* Используй классы вместо вложенности */
.menu-item__link {
  color: blue;
}

.nav-link__text {
  font-weight: bold;
}

/* Допустимая вложенность (1-2 уровня) */
.card {
  padding: 20px;
}

.card__title {
  font-size: 18px;
}

.card:hover .card__title {
  color: blue;
}
```

### 2.2 BEM методология (рекомендуется)

**BEM = Block\_\_Element_Modifier**

```css
/* Block */
.news-card {
  border: 1px solid #ccc;
}

/* Element */
.news-card__title {
  font-size: 20px;
}

.news-card__description {
  color: #666;
}

/* Modifier */
.news-card--featured {
  border-color: gold;
}

.news-card__title_large {
  font-size: 24px;
}
```

**Преимущества BEM:**

- Плоская структура (низкая специфичность)
- Самодокументируемый код
- Легко переиспользовать
- Нет конфликтов имён

## 3. Единообразие единиц измерения

### 3.1 Когда использовать px, rem, em, %

| Единица | Когда использовать                       | Примеры                                      |
| ------- | ---------------------------------------- | -------------------------------------------- |
| `px`    | Фиксированные размеры (borders, shadows) | `border: 1px solid`, `box-shadow: 0 2px 4px` |
| `rem`   | Размеры относительно root font-size      | `font-size: 1.5rem`, `padding: 2rem`         |
| `em`    | Размеры относительно parent font-size    | `margin-bottom: 0.5em`, `line-height: 1.5em` |
| `%`     | Размеры относительно parent              | `width: 50%`, `padding: 5%`                  |
| `vw/vh` | Размеры относительно viewport            | `width: 100vw`, `height: 100vh`              |

**Вариант: Система масштабирования:**

```css
:root {
  --spacing-xs: 0.25rem; /* 4px */
  --spacing-sm: 0.5rem; /* 8px */
  --spacing-md: 1rem; /* 16px */
  --spacing-lg: 1.5rem; /* 24px */
  --spacing-xl: 2rem; /* 32px */

  --font-size-sm: 0.875rem; /* 14px */
  --font-size-base: 1rem; /* 16px */
  --font-size-lg: 1.25rem; /* 20px */
  --font-size-xl: 1.5rem; /* 24px */
}

.button {
  padding: var(--spacing-sm) var(--spacing-md);
  font-size: var(--font-size-sm);
}
```

## 4. CSS переменные (Custom Properties)

### 4.1 Почему CSS переменные лучше препроцессоров?

**Преимущества CSS переменных:**

- Работают **в runtime** (можно менять через JS)
- **Не нужна компиляция**
- **Каскадные** (можно переопределить локально)
- Поддержка **media queries**

**✅ Хорошо:**

```css
:root {
  /* Цвета */
  --color-primary: #007bff;
  --color-secondary: #6c757d;
  --color-danger: #dc3545;
  --color-text: #333;
  --color-bg: #fff;

  /* Spacing */
  --spacing-unit: 8px;

  /* Transitions */
  --transition-speed: 0.3s;
  --transition-easing: ease-in-out;
}

.button {
  background: var(--color-primary);
  padding: calc(var(--spacing-unit) * 2);
  transition: all var(--transition-speed) var(--transition-easing);
}

.button:hover {
  background: var(--color-primary-dark, #0056b3); /* fallback */
}

/* Тёмная тема */
@media (prefers-color-scheme: dark) {
  :root {
    --color-text: #f0f0f0;
    --color-bg: #1a1a1a;
  }
}
```

### 4.2 Динамическое изменение через JS

```javascript
// Изменить CSS переменную
document.documentElement.style.setProperty('--color-primary', '#ff0000');

// Получить значение
const primaryColor = getComputedStyle(document.documentElement).getPropertyValue('--color-primary');
```

## 5. Responsive дизайн

### 5.1 Mobile-first подход

**❌ Плохо (desktop-first):**

```css
.container {
  width: 1200px;
}

@media (max-width: 768px) {
  .container {
    width: 100%;
  }
}
```

**✅ Хорошо (mobile-first):**

```css
.container {
  width: 100%;
  padding: 1rem;
}

@media (min-width: 768px) {
  .container {
    max-width: 1200px;
    margin: 0 auto;
  }
}
```

### 5.2 Breakpoints (рекомендуемые)

```css
:root {
  --breakpoint-sm: 576px; /* Small devices */
  --breakpoint-md: 768px; /* Tablets */
  --breakpoint-lg: 992px; /* Desktops */
  --breakpoint-xl: 1200px; /* Large desktops */
}

/* Mobile (по умолчанию) */
.grid {
  grid-template-columns: 1fr;
}

/* Tablets */
@media (min-width: 768px) {
  .grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

/* Desktops */
@media (min-width: 992px) {
  .grid {
    grid-template-columns: repeat(3, 1fr);
  }
}
```

## 6. Производительность

### 6.1 Избегай дорогих свойств

**❌ Плохо (triggers reflow):**

```css
.element {
  width: 100px;
  height: 100px;
  top: 10px;
  left: 10px;
}

/* Анимация изменяет layout! */
@keyframes move {
  from {
    left: 0;
  }
  to {
    left: 100px;
  }
}
```

**✅ Хорошо (GPU acceleration):**

```css
.element {
  width: 100px;
  height: 100px;
  transform: translate(0, 0);
  will-change: transform; /* Hint для браузера */
}

/* Анимация через transform */
@keyframes move {
  from {
    transform: translateX(0);
  }
  to {
    transform: translateX(100px);
  }
}
```

### 6.2 Оптимизация селекторов

**❌ Плохо (медленные селекторы):**

```css
/* Универсальный селектор */
* {
  margin: 0;
}

/* Attribute selector с регулярным выражением */
[class*='btn-'] {
  padding: 10px;
}

/* Глубокая вложенность */
div > ul > li > a > span {
  color: red;
}
```

**✅ Хорошо (быстрые селекторы):**

```css
/* Сброс только для нужных элементов */
body,
h1,
h2,
h3,
p,
ul,
ol {
  margin: 0;
}

/* Конкретный класс */
.button {
  padding: 10px;
}

/* Прямой класс вместо вложенности */
.nav-link__text {
  color: red;
}
```

## Checklist для CSS review

- [ ] Динамические стили через **классы** (не inline через JS)
- [ ] Вложенность селекторов **≤2 уровня**
- [ ] Единообразные единицы измерения (только rem или система)
- [ ] CSS переменные для цветов, spacing, transitions
- [ ] Mobile-first подход
- [ ] Нет `!important`
- [ ] Нет дублирования стилей
- [ ] Анимации через `transform`/`opacity` (не `left`/`top`/`width`)
- [ ] Классы в kebab-case
- [ ] Нет magic numbers (всё через переменные)

## Инструменты

**Автоматические:**

- [Stylelint](https://stylelint.io/) - линтер для CSS
- [CSS Stats](https://cssstats.com/) - анализ CSS файлов
- Chrome DevTools → Coverage - неиспользуемый CSS
