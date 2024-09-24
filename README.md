# README

Este es el desarrollo de TalaTrivia desarrollado por Carlos Bugueño. Cualquier observación, por favor con gusto lo recibiré <3

## DATOS TÉCNICOS

* Lenguaje utilizado: Ruby v. 3.1.3

* Framework: Ruby on Rails v. 7.1.4

* Sistema de authenticación JWT vía gema Devise

* Incluye `docker-compose.yml`

## SUPUESTOS A CONSIDERAR

* Toda consulta (exceptuando login, logout and submit) se deben hacer con un usuario activo

* Para consultar a la API, se debe contar con un usuario logeado. Para efectos de prueba, se usó Postman, capturando en el header el token de autenticación `authorization: Bearer abc....xyz` al momento de iniciar sesión. Dicho token debe estar presente en cada consulta, pues la API funciona sólo con usuarios logeados

* Se diferencia usuario `admin` de `player`, puntualmente en las CRUD de administración de trivias, preguntas y opciones

* La aplicación cuenta con un archivo de poblado de información básica para la base de datos. Se ejecuta en el `docker-compose.yml` al momento de iniciarlo. Por lo mismo, Si se baja el servidor y se vuelve a levantar, la información en la base de datos se borra y lo vuelve a poblar. No afecta para la dinámica de CRUD ni para la trivia en sí

* Se confía en que el usuario no es tan malicioso para botar el sistema. Aún así, se hizo lo posible para que fuese funcional, pero hay cosas que, por la escalabilidad de la API no pude integrar, como múltiples respuestas a una sola trivia, marcar respuestas como inválidad o validaciones similares.

## DOCKER

Para levantar el Docker de esta API, considere los siguientes comandos:

* `./docker-rails up` levanta el docker

* `./docker-rails down` termina la ejecución del docker

* `./docker-rails restart` termina la ejecución del docker e inmediatamente lo vuelve a iniciar

* `./docker-rails console` inicia la consola de Rails

## API

Se hace una lista de las APIs importantes para esta tarea. De todas maneras, si olvidé enlistar alguna, se puede ejecutar `rails routes` dentro de la carpeta raíz para mostrar todas las rutas de Rails y, por ende, las consultas que se pueden realizar. Está bienvenido para probar (y romper) lo que necesite de la API.

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
| Cerrar sesión | `-` |


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

#### Listar preguntas de una trivia específica

```http
  GET /trivias/:trivia_uid/questions/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Lista las preguntas asociadas a la trivia | `-` |

#### Listar opciones de una pregunta específica

```http
  GET /questions/:question_uid/options/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Lista las preguntas asociadas a la trivia | `-` |

### Manejo de Preguntas

#### Listar preguntas de una trivia específica

```http
  GET /trivias/:trivia_uid/questions/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Lista las preguntas asociadas a la trivia | `-` |

### La trivia

#### Selección de trivia

```http
  GET /trivias/select/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Se muestran las trivias del usuario actual. Se muestra el link directo para iniciar la trivia | `-` |

#### Inicio de trivia

```http
  GET /trivias/:trivia_uid/start/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| El corazón del juego. Se muestran las preguntas y opciones de la trivia, y se indica cómo responder la trivia. | `-` |

#### Envío de las respuestas

```http
  POST /anwsers/submit/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| El envío de las respuestas se debe usar con la información entregada en `/trivias/:trivia_uid/start/`. Es decir, listar según el `body` a continuación las `uid` de la opción a elegir, una por una, en el orden que se muestran las preguntas en la consulta anterior. | `{"answers": [{ "answer": "uid_opción_1" },{ "answer": "uid_opción_2" },{ "answer": "uid_opción_3" }]}` |

### PUNTUACIÓN Y SCOREBOARD

#### Puntuación del usuario

```http
  POST /anwsers/:trivia_uid/show_answers/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Se entrega la puntuación obtenida en la trivia consultada. | `-` |

#### Scoreboard

```http
  POST /anwsers/:trivia_uid/scoreboard/
```

| Descripción | Body                |
| :-------- | :------------------------- |
| Se enlista a los participantes de la trivia por puntuación obtenida. | `-` |

