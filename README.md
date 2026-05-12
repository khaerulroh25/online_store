# Online Store API

Simple Online Store REST API built using PHP Native and MySQL.

This project was created to handle flash sale transactions safely using database transactions and row locking to prevent race conditions and negative stock during concurrent requests.

---

# Features

- Create Product API
- List Products API
- Create Order API

---

# Tech Stack

- PHP Native
- MySQL
- Apache (XAMPP)
- Apache Benchmark (ab)

---

# Installation

## 1. Clone Repository

```bash
git clone https://github.com/khaerulroh25/online_store.git
```

## 2. Move Project to htdocs

```bash
C:\xampp\htdocs\
```

## 3. Create Database

Create a new database named:

```sql
online_store
```

## 4. Import Database

Import the provided SQL file:

```bash
online_store.sql
```

---

# API Endpoints

## Create Product

### Request

```http
POST /online_store/products/store.php
```

### Body

```json
{
  "name": "Iphone 15",
  "price": 15000000,
  "stock": 5
}
```

### Response

```json
{
  "message": "Product created successfully",
  "product_id": 1
}
```

---

## List Products

### Request

```http
GET /online_store/products/index.php
```

### Response

```json
{
  "data": [
    {
      "id": 1,
      "name": "Iphone 15",
      "price": "15000000.00",
      "stock": 5
    }
  ]
}
```

---

## Create Order

### Request

```http
POST /online_store/orders/store.php
```

### Body

```json
{
  "product_id": 1,
  "qty": 1
}
```

### Success Response

```json
{
  "message": "Order created successfully",
  "order_id": 1
}
```

### Failed Response

```json
{
  "message": "Stock not enough"
}
```

---

# Race Condition Testing

This project was tested using Apache Benchmark to simulate concurrent requests.

## Test Command

```bash
ab -n 20 -c 20 -p order.json -T application/json http://localhost/online_store/orders/store.php
```

## Description

- `-n 20` = total 20 requests
- `-c 20` = 20 concurrent requests

---

# Test Result

### Initial Stock

```text
5
```

### Concurrent Requests

```text
20
```

### Result

- 5 successful orders
- 15 failed orders
- Final stock = 0

---
