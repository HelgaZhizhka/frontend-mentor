# Дополнительные практики

## 1. Стрелочные функции для методов

**✅ Хорошая практика:**

```typescript
// ✅ В React
const Component = () => {
  const handleClick = () => {
    console.log('Clicked'); // this не нужен
  };

  return <button onClick={handleClick}>Click</button>;
};

// ✅ Для коллбэков
const numbers = [1, 2, 3];
const doubled = numbers.map(n => n * 2);
```

## 2. Осторожно с setTimeout и setInterval

**Проблемы:**

- Не гарантируют точность
- Могут вызывать утечки памяти
- Продолжают работать после размонтирования (React)

**❌ Плохо:**

```typescript
useEffect(() => {
  setInterval(() => {
    fetchData();
  }, 1000);
}, []); // ❌ Утечка памяти — интервал не очищается
```

**✅ Хорошо:**

```typescript
useEffect(() => {
  const interval = setInterval(() => {
    fetchData();
  }, 1000);

  return () => clearInterval(interval); // ✅ Cleanup
}, []);
```

**Альтернативы:**

```typescript
// Вместо setTimeout — async/await + delay
const delay = (ms: number) => new Promise((resolve) => setTimeout(resolve, ms));

const run = async () => {
  await delay(2000);
  console.log('After 2 seconds');
};

// Вместо setInterval — requestAnimationFrame
const tick = () => {
  console.log('Frame');
  requestAnimationFrame(tick);
};
```
