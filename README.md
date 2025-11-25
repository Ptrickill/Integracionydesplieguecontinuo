# Task API - Spring Boot CRUD con CI/CD

API REST para gestión de tareas con CRUD completo, desplegada automáticamente en Render.com mediante Docker y pipeline CI/CD.

🌐 **URL Producción:** `https://integracionydesplieguecontinuo.onrender.com/api/tasks`

---

## 📋 Endpoints

| Método | Ruta | Descripción | Body |
|--------|------|-------------|------|
| `GET` | `/api/tasks` | Listar todas las tareas | - |
| `GET` | `/api/tasks/{id}` | Obtener tarea por ID | - |
| `POST` | `/api/tasks` | Crear tarea | `{"title":"...","description":"...","completed":false}` |
| `PUT` | `/api/tasks/{id}` | Actualizar tarea | `{"title":"...","description":"...","completed":true}` |
| `PATCH` | `/api/tasks/{id}/toggle` | Cambiar estado completado/incompleto | - |
| `DELETE` | `/api/tasks/{id}` | Eliminar tarea | - |
| `GET` | `/api/tasks/completed/{true\|false}` | Filtrar por estado | - |
| `GET` | `/api/tasks/search?title=texto` | Buscar por título | - |

### Ejemplo de uso (PowerShell)

```powershell
# Crear una nueva tarea
Invoke-RestMethod -Uri "https://integracionydesplieguecontinuo.onrender.com/api/tasks" `
  -Method POST -ContentType "application/json" `
  -Body '{"title":"Estudiar Spring Boot","description":"Revisar documentación","completed":false}'

# Listar todas las tareas
Invoke-RestMethod -Uri "https://integracionydesplieguecontinuo.onrender.com/api/tasks"

# Actualizar tarea
Invoke-RestMethod -Uri "https://integracionydesplieguecontinuo.onrender.com/api/tasks/1" `
  -Method PUT -ContentType "application/json" `
  -Body '{"title":"Estudiar Spring Boot","description":"Completado","completed":true}'

# Eliminar tarea
Invoke-RestMethod -Uri "https://integracionydesplieguecontinuo.onrender.com/api/tasks/1" `
  -Method DELETE
```

---

## 🚀 Características

- ✅ **CRUD completo** - Crear, Leer, Actualizar y Eliminar tareas
- ✅ **18 tests unitarios** - Cobertura completa con JUnit 5 + Mockito
- ✅ **Pipeline CI/CD** - 3 etapas automatizadas en GitLab
- ✅ **Deployment automático** - Cada push a `main` despliega en Render.com
- ✅ **Docker multi-stage** - Imagen optimizada para producción
- ✅ **Base de datos H2** - En memoria, migrable a PostgreSQL

---

## 🔄 Pipeline CI/CD (GitLab)

El pipeline se ejecuta automáticamente en cada push con **3 etapas**:

```
┌─────────────┐     ┌─────────────┐     ┌──────────────┐
│   BUILD     │ --> │    TEST     │ --> │   PACKAGE    │
│ Compilación │     │  18 tests   │     │  Generar JAR │
└─────────────┘     └─────────────┘     └──────────────┘
```

**Configuración en `.gitlab-ci.yml`:**
1. **Build:** Compila el código con `mvn clean compile`
2. **Test:** Ejecuta tests unitarios y genera reportes JUnit
3. **Package:** Empaqueta en JAR (`demo-0.0.1-SNAPSHOT.jar`)

---

## 🐳 Deployment en Render.com

### Flujo de Deployment Automático

```
Push a GitHub → Render detecta cambios → Build Docker → Deploy → API Online ✅
```

### Dockerfile Multi-Stage

El proyecto usa un Dockerfile optimizado en 2 etapas:

**Etapa 1 (Build):** Compila con Maven
```dockerfile
FROM maven:3.9-eclipse-temurin-17 AS build
RUN mvn clean package -DskipTests
```

**Etapa 2 (Runtime):** Ejecuta solo con JRE
```dockerfile
FROM eclipse-temurin:17-jre-alpine
ENTRYPOINT ["java", "-jar", "app.jar"]
```

**Ventajas:**
- Imagen final ligera (solo JRE, sin Maven)
- Deployment reproducible
- Sin configuración manual

---

## 🛠️ Tecnologías

| Categoría | Tecnología |
|-----------|------------|
| **Lenguaje** | Java 17 |
| **Framework** | Spring Boot 3.2.0 |
| **Persistencia** | Spring Data JPA + H2 |
| **Testing** | JUnit 5 + Mockito |
| **Build** | Maven 3.9 |
| **CI/CD** | GitLab Pipeline |
| **Deployment** | Render.com + Docker |

---

## 🏃‍♂️ Ejecutar Localmente

### Requisitos
- Java 17+
- Maven 3.6+ (incluye wrapper)

### Comandos

```bash
# Ejecutar aplicación
./mvnw spring-boot:run

# Ejecutar tests
mvn test

# Crear JAR
mvn package
```

**Aplicación disponible en:** `http://localhost:8080/api/tasks`

**Consola H2:** `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:taskdb`
- Usuario: `sa` | Contraseña: *(vacía)*

---

## 📦 Estructura del Proyecto

```
demo/
├── .gitlab-ci.yml              # Pipeline CI/CD
├── Dockerfile                  # Configuración Docker
├── pom.xml                     # Dependencias Maven
└── src/
    ├── main/java/
    │   ├── controller/TaskController.java    # 9 endpoints REST
    │   ├── service/TaskService.java          # Lógica de negocio
    │   ├── repository/TaskRepository.java    # JPA Repository
    │   └── model/Task.java                   # Entidad Task
    └── test/java/
        ├── controller/TaskControllerTest.java  # 9 tests
        └── service/TaskServiceTest.java        # 9 tests
```

---

## 👥 Autores

**Grupo 9 - 5556**

- Carvajal Sandoval, José
- Díaz Mosquera, Daniel
- Guaña Romero, Roberto
- Lopez Estrella, Darwin
- Olivo Yanez, Paulo
- Puga Ayala, Isaac

---

**Repositorio:** [https://github.com/Ptrickill/Integracionydesplieguecontinuo](https://github.com/Ptrickill/Integracionydesplieguecontinuo)
