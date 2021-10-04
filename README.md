# Node & Flutter App

## Starting

Hello, below I provide the instructions to start the application

## Requeriments

```
Docker & Flutter SDK
```

## Running the Backend

Inside backend folder run the next command to build the docker container

```
docker-compose up
```

After a few seconds, you will see the following message

```
 Database On
```

## Running flutter App

Inside mobile/flutter_contacts folder run the next command

### Restore packages

```
flutter pub get
```

### Start the App

```
flutter run lib/main.dart
```

### Ports

In case of problems with the Android simulator port, use for API communication:

#### Inside:

- services/customer_service.dart
- services/auth_service.dart

#### Modify

```
final String _baseUrl = '10.0.2.2:8000';
```

---

## Testing the API 📖

### Login Request

```
http://localhost:8000/api/auth/login
```

#### Method: POST Content-Type: application/json

Body:

```
 { "username" : alex, "password" : "al3x" }
```

Valid Credentials Response Example :

```
{
"username": "alex",
"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOiIxIiwiaWF0IjoxNjMzMzExNjY5LCJleHAiOjE2MzMzNTQ4Njl9.GGJeildWWOVqJjNW_tjNeNh9jLpL0qKrdm58ue4fpd0"
}
```

---

## Customers Section

In order to access customers, a valid JWT must be supplied

---

### Get All Customers

#### Method: Get

Headers:
token-key : 'jwt'

```
http://localhost:8000/api/customers/

```

Valid JWT Response Example :

{
"customers": [
{
"id": 2,
"name": "oscar",
"phone": "111",
"email": "email@gmail.com",
"rating": 5,
"createdAt": "2021-10-03T23:52:11.000Z",
"updatedAt": "2021-10-03T23:52:11.000Z"
}
]
}

---

### Get Customer

#### Method: Get

Headers:
token-key : 'jwt'

```
http://localhost:8000/api/customers/:id

```

Valid JWT Response Example :

{
"customer": {
"id": 2,
"name": "oscar",
"phone": "111",
"email": "email@gmail.com",
"rating": 5,
"createdAt": "2021-10-03T23:52:11.000Z",
"updatedAt": "2021-10-03T23:52:11.000Z"
}
}

---

### Post Customer

#### Method: POST Content-Type: application/json

Headers:
token-key : 'jwt'

```
http://localhost:8000/api/customers/

```

Body example:

```
{
    "name": "new name",
    "phone": "11111111",
    "email": "new@email.com",
    "rating": 1
}
```

Valid JWT Response Example :

{
"customer": {
"id": 2,
"name": "new name",
"phone": "11111111",
"email": "new@email.com",
"rating": 1
"createdAt": "2021-10-03T23:52:11.000Z",
"updatedAt": "2021-10-03T23:52:11.000Z"
}
}

---

---

### Edit Customer

#### Method: PUT Content-Type: application/json

Headers:
token-key : 'jwt'

```
http://localhost:8000/api/customers/:id

```

Body example:

```
{
    "name": "new name",
    "phone": "11111111",
    "email": "new@email.com",
    "rating": 1
}
```

Valid JWT Response Example :

`id` = '2';

---

### Delete Customer

#### Method: DELETE

Headers:
token-key : 'jwt'

```
http://localhost:8000/api/customers/:id

```

Valid JWT Response Example :

```

{
"customer": {
"id": 2,
"name": "oscar",
"phone": "111",
"email": "email@gmail.com",
"rating": 5,
"createdAt": "2021-10-03T23:52:11.000Z",
"updatedAt": "2021-10-03T23:52:11.000Z"
}
}
```

## Happy Testing!!! 🤓 🎁

---
