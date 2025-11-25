# API REST de Tareas - Spring Boot

API REST completa con CRUD para gestión de tareas, con pipeline CI/CD configurado para GitLab y deployment en Render.

## 🚀 Características

- **CRUD Completo** de Tareas (Crear, Leer, Actualizar, Eliminar)
- **Búsqueda y Filtrado** por estado y título
- **Base de datos H2** en memoria (configurable a PostgreSQL/MySQL)
- **Pruebas Unitarias** completas
- **Pipeline CI/CD** con 3 etapas
- **Despliegue automático** en Render.com

## 📋 Endpoints de la API

### Tareas

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | `/api/tasks` | Obtener todas las tareas |
| GET | `/api/tasks/{id}` | Obtener una tarea por ID |
| GET | `/api/tasks/status/{completed}` | Filtrar por estado (true/false) |
| GET | `/api/tasks/search?title=texto` | Buscar por título |
| POST | `/api/tasks` | Crear nueva tarea |
| PUT | `/api/tasks/{id}` | Actualizar tarea |
| PATCH | `/api/tasks/{id}/toggle` | Alternar estado completado |
| DELETE | `/api/tasks/{id}` | Eliminar tarea |
| GET | `/api/tasks/health` | Health check |

### Ejemplos de Uso

**Crear una tarea:**
```bash
curl -X POST http://localhost:8080/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Comprar víveres",
    "description": "Leche, pan y frutas",
    "completed": false
  }'
```

**Obtener todas las tareas:**
```bash
curl http://localhost:8080/api/tasks
```

**Actualizar una tarea:**
```bash
curl -X PUT http://localhost:8080/api/tasks/1 \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Comprar víveres (actualizado)",
    "description": "Leche, pan, frutas y verduras",
    "completed": true
  }'
```

**Eliminar una tarea:**
```bash
curl -X DELETE http://localhost:8080/api/tasks/1
```

## 🛠️ Tecnologías Utilizadas

- **Java 17**
- **Spring Boot 4.0.0**
- **Spring Data JPA**
- **H2 Database**
- **Maven**
- **JUnit 5**
- **Mockito**

## 🏃‍♂️ Ejecución Local

### Requisitos previos
- Java 17 o superior
- Maven 3.6+

### Ejecutar la aplicación

```bash
# Compilar
mvn clean compile

# Ejecutar tests
mvn test

# Empaquetar
mvn package

# Ejecutar la aplicación
java -jar target/demo-0.0.1-SNAPSHOT.jar
```

O usar el wrapper de Maven:
```bash
# Windows
mvnw.cmd spring-boot:run

# Linux/Mac
./mvnw spring-boot:run
```

La aplicación estará disponible en `http://localhost:8080`

## 🔧 Consola H2

Accede a la consola de base de datos en: `http://localhost:8080/h2-console`

- **JDBC URL:** `jdbc:h2:mem:taskdb`
- **Usuario:** `sa`
- **Contraseña:** *(vacía)*

## 🔄 Pipeline CI/CD

El pipeline de GitLab CI/CD incluye 3 etapas:

### 1. **Build** 
Compila el proyecto con Maven

### 2. **Test**
Ejecuta todas las pruebas unitarias y genera reportes

### 3. **Package**
- Empaqueta la aplicación en un archivo JAR
- Genera artifact para deployment

## ⚙️ Deployment en Render.com

La aplicación está configurada para desplegarse automáticamente en Render.com:

1. Conecta tu repositorio de GitLab/GitHub con Render
2. Render detecta automáticamente que es una aplicación Spring Boot
3. Cada push a `main` despliega automáticamente
4. URL pública generada automáticamente

Ver `RENDER_SETUP.md` para instrucciones detalladas.

## 📦 Estructura del Proyecto

```
demo/
├── src/
│   ├── main/
│   │   ├── java/com/example/demo/
│   │   │   ├── controller/
│   │   │   │   └── TaskController.java
│   │   │   ├── model/
│   │   │   │   └── Task.java
│   │   │   ├── repository/
│   │   │   │   └── TaskRepository.java
│   │   │   ├── service/
│   │   │   │   └── TaskService.java
│   │   │   └── DemoApplication.java
│   │   └── resources/
│   │       └── application.properties
│   └── test/
│       └── java/com/example/demo/
│           ├── controller/
│           │   └── TaskControllerTest.java
│           ├── service/
│           │   └── TaskServiceTest.java
│           └── DemoApplicationTests.java
├── .gitlab-ci.yml
├── pom.xml
└── README.md
```

## 🧪 Ejecutar Tests

```bash
# Ejecutar todos los tests
mvn test

# Ejecutar con reporte de cobertura
mvn test jacoco:report
```

## 📝 Notas Importantes

1. **Base de Datos:**
   - Actualmente usa H2 en memoria (los datos se pierden al reiniciar)
   - Para producción en Render, puedes usar PostgreSQL gratuito

2. **Puerto de la aplicación:**
   - Configurable en `application.properties` con `server.port`
   - Render asigna automáticamente el puerto mediante variable de entorno

3. **Variables de entorno:**
   - Configúralas en Render Dashboard para diferentes ambientes

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

## 📧 Contacto

Para preguntas o sugerencias, abre un issue en el repositorio.

---

**¡Happy Coding! 🚀**
