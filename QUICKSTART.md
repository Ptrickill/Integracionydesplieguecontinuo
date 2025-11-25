# ⚡ Guía Rápida - Task API con CI/CD

## 🎯 Lo que se ha creado

✅ **API REST completa** con CRUD de Tareas
✅ **Base de datos H2** en memoria
✅ **Tests unitarios** (18 tests - todos pasan)
✅ **Pipeline CI/CD** con 3 etapas configurado
✅ **Deployment en Render.com** listo
✅ **Documentación** completa

---

## 📁 Estructura del Proyecto

```
demo/
├── Procfile                    ← Comando para Render
├── render.json                 ← Configuración de Render
├── .gitlab-ci.yml              ← Pipeline CI/CD
├── pom.xml                     ← Dependencias Maven
├── README.md                   ← Documentación completa
├── RENDER_SETUP.md             ← Guía de deployment Render
├── verify-setup.ps1            ← Script de verificación
├── .gitignore                  ← Archivos ignorados por Git
│
├── src/main/java/com/example/demo/
│   ├── DemoApplication.java           ← Aplicación principal
│   ├── controller/
│   │   └── TaskController.java        ← 9 endpoints REST
│   ├── model/
│   │   └── Task.java                  ← Entidad JPA
│   ├── repository/
│   │   └── TaskRepository.java        ← Acceso a datos
│   └── service/
│       └── TaskService.java           ← Lógica de negocio
│
├── src/test/java/com/example/demo/
│   ├── controller/
│   │   └── TaskControllerTest.java    ← 9 tests
│   └── service/
│       └── TaskServiceTest.java       ← 8 tests
│
└── src/main/resources/
    └── application.properties          ← Configuración
```

---

## 🚀 Comandos Útiles

### Desarrollo Local

```bash
# Compilar
.\mvnw.cmd clean compile

# Ejecutar tests
.\mvnw.cmd test

# Empaquetar
.\mvnw.cmd package

# Ejecutar aplicación
.\mvnw.cmd spring-boot:run
# o
java -jar target/demo-0.0.1-SNAPSHOT.jar
```

### Endpoints de la API (Local)

```bash
# Health check
curl http://localhost:8080/api/tasks/health

# Crear tarea
curl -X POST http://localhost:8080/api/tasks -H "Content-Type: application/json" -d "{\"title\":\"Test\",\"description\":\"Descripción\",\"completed\":false}"

# Listar tareas
curl http://localhost:8080/api/tasks

# Obtener tarea por ID
curl http://localhost:8080/api/tasks/1

# Actualizar tarea
curl -X PUT http://localhost:8080/api/tasks/1 -H "Content-Type: application/json" -d "{\"title\":\"Actualizada\",\"description\":\"Nueva descripción\",\"completed\":true}"

# Eliminar tarea
curl -X DELETE http://localhost:8080/api/tasks/1
```

---

## 📋 Pipeline CI/CD - 3 Etapas

### 1. 🔨 BUILD
- Compila el proyecto con Maven
- Genera artifacts para las siguientes etapas

### 2. ✅ TEST
- Ejecuta 18 tests unitarios
- Genera reportes JUnit
- Falla el pipeline si algún test falla

### 3. 📦 PACKAGE
- Empaqueta la aplicación en un JAR ejecutable
- Genera artifact para deployment
- Solo se ejecuta en ramas `main` o `master`

---

## 🚀 Deployment en Render.com

### ¿Por qué Render?
- ✅ **100% Gratis** - Sin tarjeta de crédito
- ✅ **Deploy automático** - Con cada push a main
- ✅ **SSL gratis** - HTTPS automático
- ✅ **URL pública** - Accesible desde cualquier lugar
- ✅ **Fácil configuración** - 5 minutos

### Pasos Rápidos:

1. **Sube el código a GitLab/GitHub**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://gitlab.com/TU_USUARIO/task-api.git
   git push -u origin main
   ```

2. **Crea cuenta en Render.com**
   - Ve a https://render.com
   - Regístrate (gratis, no necesita tarjeta)

3. **Crea Web Service**
   - New + → Web Service
   - Conecta tu repositorio
   - Build Command: `./mvnw clean package -DskipTests`
   - Start Command: `java -jar target/demo-0.0.1-SNAPSHOT.jar`
   - Instance Type: **Free**

4. **¡Listo!**
   - Render despliega automáticamente
   - Obtienes URL: `https://task-api-xxxx.onrender.com`

**Ver guía completa:** `RENDER_SETUP.md`

---

## 📤 Subir a GitLab/GitHub

```bash
# 1. Inicializar Git
git init

# 2. Agregar archivos
git add .
git commit -m "Initial commit: Task API with CI/CD and Render deployment"

# 3. Agregar remote
# Para GitLab:
git remote add origin https://gitlab.com/TU_USUARIO/task-api.git

# Para GitHub:
# git remote add origin https://github.com/TU_USUARIO/task-api.git

# 4. Push
git branch -M main
git push -u origin main
```

El pipeline de GitLab se ejecutará automáticamente.
Luego configura Render para deploy automático.

---

## 🧪 Probar en Producción

Una vez desplegado en Render:

```bash
# Reemplaza con tu URL de Render
export API_URL="https://task-api-xxxx.onrender.com"

# Health check
curl $API_URL/api/tasks/health

# Crear tarea
curl -X POST $API_URL/api/tasks -H "Content-Type: application/json" -d "{\"title\":\"Desplegada en Render\",\"description\":\"Funcionando!\",\"completed\":false}"

# Listar todas
curl $API_URL/api/tasks
```

---

## 🐛 Troubleshooting Rápido

### Pipeline falla en GitLab

**Solución:**
1. Revisa los logs del job en GitLab
2. Verifica que Maven pueda compilar localmente: `mvnw clean package`
3. Asegúrate de que todos los tests pasen: `mvnw test`

### Render no encuentra el JAR

**Solución:**
1. Verifica el Build Command: `./mvnw clean package -DskipTests`
2. Asegúrate de que `mvnw` esté en el repositorio
3. Revisa los logs de build en Render

### La aplicación se "duerme" en Render

**Info:**
- En el plan gratuito, la app se duerme tras 15 min sin uso
- El primer request después tarda ~30 segundos
- Es normal y no afecta la funcionalidad

---

## 📊 Verificación del Proyecto

Ejecuta el script de verificación:

```bash
# PowerShell
.\verify-setup.ps1

# Bash/Linux
chmod +x verify-setup.sh
./verify-setup.sh
```

---

## 📚 Documentación Completa

- **README.md** - Documentación técnica detallada
- **RENDER_SETUP.md** - Guía completa de deployment en Render
- **API_EXAMPLES.md** - Ejemplos de todos los endpoints
- **Esta guía** - Referencia rápida

---

## ✅ Checklist Final

Antes de hacer el primer deploy:

- [ ] Proyecto compila sin errores (`mvnw clean compile`)
- [ ] Tests pasan correctamente (`mvnw test`)
- [ ] Código subido a GitLab/GitHub
- [ ] Pipeline de GitLab ejecutándose correctamente
- [ ] Cuenta en Render.com creada
- [ ] Web Service en Render configurado
- [ ] Aplicación desplegada y accesible

---

## 🎉 ¡Listo para Producción!

Tu aplicación está lista para ser desplegada automáticamente.

**Flujo de trabajo:**
1. Haces cambios en el código
2. Ejecutas tests localmente
3. Haces `git commit` y `git push`
4. GitLab ejecuta el pipeline (build → test → package)
5. Render detecta el push y despliega automáticamente
6. ¡Aplicación actualizada y funcionando en producción!

**URL de tu API:** `https://task-api-xxxx.onrender.com`

---

**¿Preguntas o problemas?** Revisa los logs del pipeline en GitLab → CI/CD → Pipelines
