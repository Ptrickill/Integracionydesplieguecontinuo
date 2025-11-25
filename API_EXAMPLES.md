# 📝 Ejemplos de Uso - Task API

Colección de ejemplos prácticos para probar todos los endpoints de la API.

---

## 🔗 URL Base

**Local:** `http://localhost:8080`
**Producción:** `http://TU_IP_EC2:8080`

---

## 📍 Endpoints Disponibles

### 1. Health Check ✅

Verifica que la API esté funcionando.

**Request:**
```bash
curl http://localhost:8080/api/tasks/health
```

**Response:**
```
API de Tareas funcionando correctamente
```

---

### 2. Crear Tarea 📝

Crea una nueva tarea.

**Request:**
```bash
curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Comprar víveres",
    "description": "Leche, pan, huevos y frutas",
    "completed": false
  }'
```

**Response:**
```json
{
  "id": 1,
  "title": "Comprar víveres",
  "description": "Leche, pan, huevos y frutas",
  "completed": false,
  "createdAt": "2025-11-23T20:30:00",
  "updatedAt": "2025-11-23T20:30:00"
}
```

---

### 3. Listar Todas las Tareas 📋

Obtiene todas las tareas.

**Request:**
```bash
curl http://localhost:8080/api/tasks
```

**Response:**
```json
[
  {
    "id": 1,
    "title": "Comprar víveres",
    "description": "Leche, pan, huevos y frutas",
    "completed": false,
    "createdAt": "2025-11-23T20:30:00",
    "updatedAt": "2025-11-23T20:30:00"
  },
  {
    "id": 2,
    "title": "Estudiar Spring Boot",
    "description": "Revisar documentación oficial",
    "completed": true,
    "createdAt": "2025-11-23T20:31:00",
    "updatedAt": "2025-11-23T20:35:00"
  }
]
```

---

### 4. Obtener Tarea por ID 🔍

Obtiene una tarea específica.

**Request:**
```bash
curl http://localhost:8080/api/tasks/1
```

**Response:**
```json
{
  "id": 1,
  "title": "Comprar víveres",
  "description": "Leche, pan, huevos y frutas",
  "completed": false,
  "createdAt": "2025-11-23T20:30:00",
  "updatedAt": "2025-11-23T20:30:00"
}
```

**Error (404):**
```json
{
  "timestamp": "2025-11-23T20:30:00",
  "status": 404,
  "error": "Not Found"
}
```

---

### 5. Actualizar Tarea ✏️

Actualiza una tarea existente.

**Request:**
```bash
curl -X PUT http://localhost:8080/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Comprar víveres (actualizado)",
    "description": "Leche, pan, huevos, frutas Y verduras",
    "completed": true
  }'
```

**Response:**
```json
{
  "id": 1,
  "title": "Comprar víveres (actualizado)",
  "description": "Leche, pan, huevos, frutas Y verduras",
  "completed": true,
  "createdAt": "2025-11-23T20:30:00",
  "updatedAt": "2025-11-23T20:40:00"
}
```

---

### 6. Alternar Estado de Completado 🔄

Cambia el estado completed de true a false o viceversa.

**Request:**
```bash
curl -X PATCH http://localhost:8080/api/tasks/1/toggle
```

**Response:**
```json
{
  "id": 1,
  "title": "Comprar víveres",
  "description": "Leche, pan, huevos y frutas",
  "completed": true,
  "createdAt": "2025-11-23T20:30:00",
  "updatedAt": "2025-11-23T20:45:00"
}
```

---

### 7. Filtrar por Estado ✔️❌

Obtiene tareas completadas o pendientes.

**Tareas Completadas:**
```bash
curl http://localhost:8080/api/tasks/status/true
```

**Tareas Pendientes:**
```bash
curl http://localhost:8080/api/tasks/status/false
```

**Response:**
```json
[
  {
    "id": 2,
    "title": "Estudiar Spring Boot",
    "description": "Revisar documentación oficial",
    "completed": true,
    "createdAt": "2025-11-23T20:31:00",
    "updatedAt": "2025-11-23T20:35:00"
  }
]
```

---

### 8. Buscar por Título 🔎

Busca tareas que contengan el texto especificado (no distingue mayúsculas/minúsculas).

**Request:**
```bash
curl "http://localhost:8080/api/tasks/search?title=comprar"
```

**Response:**
```json
[
  {
    "id": 1,
    "title": "Comprar víveres",
    "description": "Leche, pan, huevos y frutas",
    "completed": false,
    "createdAt": "2025-11-23T20:30:00",
    "updatedAt": "2025-11-23T20:30:00"
  }
]
```

---

### 9. Eliminar Tarea 🗑️

Elimina una tarea.

**Request:**
```bash
curl -X DELETE http://localhost:8080/api/tasks/1
```

**Response:** `204 No Content` (sin cuerpo)

**Error (404):**
```json
{
  "timestamp": "2025-11-23T20:30:00",
  "status": 404,
  "error": "Not Found"
}
```

---

## 🧪 Escenarios de Prueba Completos

### Escenario 1: CRUD Básico

```bash
# 1. Crear tarea
curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Tarea de prueba","description":"Descripción","completed":false}'

# 2. Listar todas
curl http://localhost:8080/api/tasks

# 3. Obtener por ID (asumiendo ID=1)
curl http://localhost:8080/api/tasks/1

# 4. Actualizar
curl -X PUT http://localhost:8080/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{"title":"Tarea actualizada","description":"Nueva descripción","completed":true}'

# 5. Eliminar
curl -X DELETE http://localhost:8080/api/tasks/1

# 6. Verificar que se eliminó
curl http://localhost:8080/api/tasks/1
```

---

### Escenario 2: Gestión de Tareas Pendientes

```bash
# Crear varias tareas
curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Tarea 1","description":"Pendiente","completed":false}'

curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Tarea 2","description":"Completada","completed":true}'

curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Tarea 3","description":"Pendiente","completed":false}'

# Ver solo pendientes
curl http://localhost:8080/api/tasks/status/false

# Completar una tarea (toggle)
curl -X PATCH http://localhost:8080/api/tasks/1/toggle

# Ver solo completadas
curl http://localhost:8080/api/tasks/status/true
```

---

### Escenario 3: Búsqueda y Filtrado

```bash
# Crear tareas con diferentes títulos
curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Comprar leche","description":"Supermercado","completed":false}'

curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Estudiar Java","description":"Capítulo 5","completed":false}'

curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Comprar pan","description":"Panadería","completed":false}'

# Buscar tareas relacionadas con "comprar"
curl "http://localhost:8080/api/tasks/search?title=comprar"

# Buscar tareas relacionadas con "estudiar"
curl "http://localhost:8080/api/tasks/search?title=estudiar"
```

---

## 🔧 PowerShell (Windows)

Si usas PowerShell, usa estas versiones:

### Crear Tarea
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/tasks" -Method Post `
  -Headers @{"Content-Type"="application/json"} `
  -Body '{"title":"Tarea desde PowerShell","description":"Funciona!","completed":false}'
```

### Listar Tareas
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/tasks" -Method Get
```

### Actualizar Tarea
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/tasks/1" -Method Put `
  -Headers @{"Content-Type"="application/json"} `
  -Body '{"title":"Actualizada","description":"Desde PowerShell","completed":true}'
```

### Eliminar Tarea
```powershell
Invoke-RestMethod -Uri "http://localhost:8080/api/tasks/1" -Method Delete
```

---

## 🌐 Probar con Navegador

Algunos endpoints GET se pueden probar directamente en el navegador:

- **Health Check:** http://localhost:8080/api/tasks/health
- **Listar todas:** http://localhost:8080/api/tasks
- **Obtener por ID:** http://localhost:8080/api/tasks/1
- **Filtrar completadas:** http://localhost:8080/api/tasks/status/true
- **Buscar:** http://localhost:8080/api/tasks/search?title=comprar

---

## 🔍 Herramientas Recomendadas

### Postman
1. Descarga: https://www.postman.com/downloads/
2. Crea una nueva colección
3. Importa los ejemplos de arriba

### Insomnia
1. Descarga: https://insomnia.rest/download
2. Crea un nuevo workspace
3. Agrega los requests

### Thunder Client (VS Code Extension)
1. Instala la extensión en VS Code
2. Crea una nueva colección
3. Agrega los requests

---

## 📊 Códigos de Estado HTTP

| Código | Descripción | Cuándo se usa |
|--------|-------------|---------------|
| 200 OK | Éxito | GET, PUT, PATCH exitosos |
| 201 Created | Recurso creado | POST exitoso |
| 204 No Content | Éxito sin contenido | DELETE exitoso |
| 404 Not Found | No encontrado | GET, PUT, DELETE de ID inexistente |
| 500 Internal Server Error | Error del servidor | Error inesperado |

---

## 💡 Tips

1. **Formato JSON:** Asegúrate de que el JSON esté bien formado
2. **IDs:** Los IDs se asignan automáticamente (autoincremental)
3. **Búsqueda:** La búsqueda por título no distingue mayúsculas/minúsculas
4. **Base de datos:** H2 es en memoria, los datos se pierden al reiniciar
5. **CORS:** Está habilitado para permitir peticiones desde cualquier origen

---

## 🎯 Prueba Completa Rápida

Copia y pega este script para probar todos los endpoints:

```bash
#!/bin/bash
BASE_URL="http://localhost:8080/api/tasks"

echo "1. Health Check"
curl $BASE_URL/health
echo -e "\n"

echo "2. Crear Tarea 1"
curl -X POST $BASE_URL -H "Content-Type: application/json" -d '{"title":"Tarea 1","description":"Primera tarea","completed":false}'
echo -e "\n"

echo "3. Crear Tarea 2"
curl -X POST $BASE_URL -H "Content-Type: application/json" -d '{"title":"Tarea 2","description":"Segunda tarea","completed":false}'
echo -e "\n"

echo "4. Listar Todas"
curl $BASE_URL
echo -e "\n"

echo "5. Obtener Tarea 1"
curl $BASE_URL/1
echo -e "\n"

echo "6. Actualizar Tarea 1"
curl -X PUT $BASE_URL/1 -H "Content-Type: application/json" -d '{"title":"Tarea 1 Actualizada","description":"Actualizada","completed":true}'
echo -e "\n"

echo "7. Toggle Tarea 1"
curl -X PATCH $BASE_URL/1/toggle
echo -e "\n"

echo "8. Filtrar Pendientes"
curl $BASE_URL/status/false
echo -e "\n"

echo "9. Buscar por título"
curl "$BASE_URL/search?title=tarea"
echo -e "\n"

echo "10. Eliminar Tarea 1"
curl -X DELETE $BASE_URL/1
echo -e "\n"

echo "¡Prueba completa!"
```

---

¡Disfruta probando tu API! 🚀
