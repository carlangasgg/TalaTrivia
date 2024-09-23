# README

Este es el desarrollo de TalaTrivia desarrollado por Carlos Bugueño

## DATOS TÉCNICOS

* Lenguaje utilizado: Ruby v. 3.1.3

* Framework: Ruby on Rails v. 7.1.4

* Sistema de authenticación JWT vía gema Devise

* Incluye `docker-compose.yml`

## SUPUESTOS A CONSIDERAR

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## DOCKER

Para levantar el Docker de esta API, considere los siguientes comandos:

* `./docker-rails up` levanta el docker

* `./docker-rails down` termina la ejecución del docker

* `./docker-rails restart` termina la ejecución del docker e inmediatamente lo vuelve a iniciar

* `./docker-rails console` inicia la consola de Rails

## API

### Autenticación

#### Sign up

```http
  POST /signup
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Crear usuario | `{ "user": { "email": "email", "password": "password", "name": "name"} }` |

#### Log in

```http
  POST /login
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Iniciar sesión | `{ "user": { "email": "email", "password": "password" } }` |

#### Log out

```http
  DELETE /logout
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Cerrar sesión | `{ "user": { "email": "email", "password": "password" } }` |


### CRUD trivias

#### Ver trivias disponibles

```http
  GET /trivias/trivia
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Enlistar trivias creadas | `-` |

#### Ver trivia específica

```http
  GET /trivias/trivia/:trivia_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Mostrar trivia específica | `-` |

#### Crear trivia

```http
  POST /trivias/trivia/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Crear trivia | `{ "trivium": { "name": "name", "description": "description" } }` |

#### Editar trivia

```http
  PATCH /trivias/trivia/:trivia_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Editar trivia específica | `{ "trivium": { "name": "name", "description": "description" } }` |

#### Eliminar trivia

```http
  DELETE /trivias/trivia/:trivia_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Eliminar trivia | `-` |

### CRUD preguntas

#### Ver preguntas disponibles

```http
  GET /questions/questions
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Enlistar preguntas creadas | `-` |

#### Ver pregunta específica

```http
  GET /questions/questions/:question_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Mostrar pregunta específica | `-` |

#### Crear pregunta

```http
  POST /questions/questions/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Crear pregunta. IMPORTANTE: en este punto, la pregunta ya queda asociada a la trivia si se agrega el `uid` de la trivia correctamente. | `{ "question": { "name": "name", "description": "description", "score": score, trivium_id: trivium_uid } }` |

#### Editar pregunta

```http
  PATCH /questions/questions/:question_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Editar pregunta específica | `{ "question": { "name": "name", "description": "description", "score": score } }` |

#### Eliminar pregunta

```http
  DELETE /questions/questions/:question_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Eliminar pregunta | `-` |

### CRUD opciones

#### Ver opciones disponibles

```http
  GET /questions/options
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Enlistar opciones creadas | `-` |

#### Ver opción específica

```http
  GET /questions/options/:option_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Mostrar opción específica | `-` |

#### Crear opción

```http
  POST /questions/options/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Crear pregunta. IMPORTANTE: en este punto, la opción ya queda asociada a la pregunta si se agrega el `uid` de la pregunta correctamente. | `{ "option": { "name": "name", "correct_option": "true/false", question_id: question_uid } }` |

#### Editar opción

```http
  PATCH /questions/options/:option_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Editar opción específica | `{ "option": { "name": "name", "correct_option": "true/false" } }` |

#### Eliminar opción

```http
  DELETE /questions/options/:option_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Eliminar opción | `-` |

### Manejo de usuarios

#### Listar jugadores

```http
  GET /trivias/players
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Listar todos los jugadores disponibles | `-` |

#### Listar jugadores de una trivia

```http
  GET /trivias/:trivia_uid/players
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Listar jugadores de una trivia | `-` |

#### Agregar jugador a una trivia

```http
  POST /trivias/:trivia_uid/user/:user_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Agregar usuario a una trivia | `-` |

#### Quitar jugador de una trivia

```http
  DELETE /trivias/:trivia_uid/user/:user_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Quitar usuario de una trivia | `-` |

### Manejo de Preguntas

#### Listar preguntas una trivia específica

```http
  DELETE /trivias/:trivia_uid/questions/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Lista las preguntas asociadas a la trivia | `-` |




