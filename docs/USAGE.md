# USAGE

# š Collection: auth

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

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

# š Collection: posts

## End-point: Cadastrar post

### Method: POST

> ```
> {{base_url}}/post
> ```

### Body (**raw**)

```json
{
  "title": "asdf asdf asdf",
  "content": "Tudo isso aĆ­ Ć© inveja 123"
}
```

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

## End-point: Atualizar um post por UUID

### Method: PUT

> ```
> {{base_url}}/post/:uuid
> ```

### Body (**raw**)

```json
{
  "content": "Tudo isso aĆ­ Ć© inveja"
}
```

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

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

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

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

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

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

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

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

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

# š Collection: users

## End-point: Listar usuĆ”rios

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

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

## End-point: Visualizar usuĆ”rio por UUID

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

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

## End-point: Excluir usuĆ”rio logado

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

### š Authentication bearer

| Param | value     | Type   |
| ----- | --------- | ------ |
| token | {{token}} | string |

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

## End-point: Cadastrar UsuĆ”rio

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

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

## End-point: health

### Method: GET

> ```
> {{base_url}}/health
> ```

ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā ā

---

Powered By: [postman-to-markdown](https://github.com/bautistaj/postman-to-markdown/)
