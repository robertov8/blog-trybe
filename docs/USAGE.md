# USAGE

# 📁 Collection: auth

## End-point: Login

### Method: POST

> ```
> {{base_url}}/login
> ```

### Body (**raw**)

```json
{
  "email": "rei@camarote.com",
  "password": "camarote123"
}
```

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

# 📁 Collection: posts

## End-point: Cadastrar post

### Method: POST

> ```
> {{base_url}}/post
> ```

### Body (**raw**)

```json
{
  "title": "asdf asdf asdf",
  "content": "Tudo isso aí é inveja 123"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Atualizar um post por UUID

### Method: PUT

> ```
> {{base_url}}/post/:uuid
> ```

### Body (**raw**)

```json
{
  "content": "Tudo isso aí é inveja"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Listar posts

### Method: GET

> ```
> {{base_url}}/user
> ```

### Body (**raw**)

```json
{
  "displayName": "Rei do Camarote",
  "email": "rei1@camarote.com",
  "password": "camarote123",
  "image": "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Visualizar post por UUID

### Method: GET

> ```
> {{base_url}}/post/:uuid
> ```

### Body (**raw**)

```json
{
  "displayName": "Rei do Camarote",
  "email": "rei1@camarote.com",
  "password": "camarote123",
  "image": "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Buscar post por termo

### Method: GET

> ```
> {{base_url}}/post/search
> ```

### Body (**raw**)

```json
{
  "displayName": "Rei do Camarote",
  "email": "rei1@camarote.com",
  "password": "camarote123",
  "image": "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Excluir post

### Method: DELETE

> ```
> {{base_url}}/post/:uuid
> ```

### Body (**raw**)

```json
{
  "displayName": "Rei do Camarote",
  "email": "rei1@camarote.com",
  "password": "camarote123",
  "image": "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

# 📁 Collection: users

## End-point: Listar usuários

### Method: GET

> ```
> {{base_url}}/user
> ```

### Body (**raw**)

```json
{
  "displayName": "Rei do Camarote",
  "email": "rei1@camarote.com",
  "password": "camarote123",
  "image": "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Visualizar usuário por UUID

### Method: GET

> ```
> {{base_url}}/user/:uuid
> ```

### Body (**raw**)

```json
{
  "displayName": "Rei do Camarote",
  "email": "rei1@camarote.com",
  "password": "camarote123",
  "image": "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Excluir usuário logado

### Method: DELETE

> ```
> {{base_url}}/user/me
> ```

### Body (**raw**)

```json
{
  "displayName": "Rei do Camarote",
  "email": "rei1@camarote.com",
  "password": "camarote123",
  "image": "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
}
```

### 🔑 Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: Cadastrar Usuário

### Method: POST

> ```
> {{base_url}}/user
> ```

### Body (**raw**)

```json
{
  "displayName": "Rei do Camarote",
  "email": "rei@camarote.com",
  "password": "camarote123",
  "image": "https://storage.googleapis.com/adm-portal.appspot.com/noticias/_imgHighlight/279020/noticia_81671.jpg?mtime=20181101174525&focal=none"
}
```

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

## End-point: health

### Method: GET

> ```
> {{base_url}}/health
> ```

⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃ ⁃

---

Powered By: [postman-to-markdown](https://github.com/bautistaj/postman-to-markdown/)
