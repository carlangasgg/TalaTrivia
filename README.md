# README

Este es el desarrollo de TalaTrivia desarrollado por Carlos Bugueño

## DATOS TÉCNICOS

* Lenguaje utilizado: Ruby v. 3.1.3

* Framework: Ruby on Rails v. 7.1.4

* Sistema de authenticación JWT vía gema Devise

* Incluye ´docker-compose.yml´

## SUPUESTOS A CONSIDERAR

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## DOCKER

Para levantar el Docker de esta API, considere los siguientes comandos:

* ´./docker-rails up´ levanta el docker

* ´./docker-rails down´ termina la ejecución del docker

* ´./docker-rails restart´ termina la ejecución del docker e inmediatamente lo vuelve a iniciar

* ´./docker-rails console´ inicia la consola de Rails

## API

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
  POST /logout
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Cerrar sesión | `{ "user": { "email": "email", "password": "password" } }` |


