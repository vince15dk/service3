# `SMS-Webhook-api`

### Execute it in local env
```bash
make run
```
<br/>

### Debugging Handler
```
GET {host}:4000/test    // Liveness probe check

GET {host}:4000/testauth  // Authentication Test
```

<br/>

### Api Service Handler
* GET
```
GET {host}:3000/users/token    
GET {host}:3000/users/:page/:rows  
GET {host}:3000/users/:page/:id 
```
* POST
```
POST {host}:3000/users   
```
* PUT
```
PUT {host}:3000/users/:id
```
* Delete
```
DELETE {host}:3000/users/:id
```
<br/>
