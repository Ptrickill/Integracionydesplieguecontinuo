# Task API - Spring Boot CRUD con CI/CD

API REST para gestión de tareas desplegada en **Render.com** con pipeline CI/CD.

🌐 **URL Producción:** `https://integracionydesplieguecontinuo.onrender.com`

## 📋 Endpoints Disponibles

```bash
# Ver todas las tareas
GET /api/tasks

# Crear tarea
POST /api/tasks
Body: {"title":"Título","description":"Descripción","completed":false}

# Ver tarea específica
GET /api/tasks/{id}

# Actualizar tarea
PUT /api/tasks/{id}

# Marcar completada/incompleta
PATCH /api/tasks/{id}/toggle

# Eliminar tarea
DELETE /api/tasks/{id}

# Filtrar por estado
GET /api/tasks/completed/{true|false}

# Buscar por título
GET /api/tasks/search?title=palabra
```

## 💡 Ejemplo Rápido

```powershell
# Crear tarea
Invoke-RestMethod -Uri "https://integracionydesplieguecontinuo.onrender.com/api/tasks" `
  -Method POST -ContentType "application/json" `
  -Body '{"title":"Mi tarea","description":"Hacer algo","completed":false}'

# Ver todas
Invoke-RestMethod -Uri "https://integracionydesplieguecontinuo.onrender.com/api/tasks"
```

## 🚀 Características

- ✅ CRUD completo de tareas
- ✅ 18 tests unitarios (JUnit + Mockito)
- ✅ Pipeline CI/CD GitLab (3 etapas: Build, Test, Package)
- ✅ Desplegado en Render.com con Docker
- ✅ Base de datos H2 en memoria

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
