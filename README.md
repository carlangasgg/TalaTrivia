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
  GET /trivias/trivia/:uid
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
  PATCH /trivias/trivia/:uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Editar trivia específica | `{ "trivium": { "name": "name", "description": "description" } }` |

#### Eliminar trivia

```http
  DELETE /trivias/trivia/:uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Eliminar trivia | `-` |

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
  GET /trivias/:id/players
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Listar jugadores de una trivia | `-` |

#### Agregar jugador a una trivia

```http
  POST /trivias/:id/user/:user_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Agregar usuario a una trivia | `-` |

#### Quitar jugador de una trivia

```http
  DELETE /trivias/:id/user/:user_uid
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Quitar usuario de una trivia | `-` |

