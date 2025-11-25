# 🚀 Deploy en Render.com - Guía Paso a Paso

Esta guía te ayudará a desplegar tu API de Tareas en Render.com de forma **100% gratuita** y automática.

---

## ✨ ¿Por qué Render?

- ✅ **Gratis** - No necesitas tarjeta de crédito
- ✅ **Fácil** - Deploy automático con cada push
- ✅ **Rápido** - Tu app estará online en minutos
- ✅ **SSL gratis** - HTTPS automático
- ✅ **URL pública** - Acceso desde cualquier lugar

---

## 📋 Prerequisitos

1. Cuenta en GitLab o GitHub (gratis)
2. Cuenta en Render.com (gratis - crea una en https://render.com)
3. Tu código subido a GitLab/GitHub

---

## 🔧 Paso 1: Preparar el Repositorio

### 1.1 Subir el Código a GitLab/GitHub

Si aún no has subido tu código:

```bash
# Navegar a la carpeta del proyecto
cd demo

# Inicializar Git
git init

# Agregar archivos
git add .

# Primer commit
git commit -m "Initial commit: Task API for Render deployment"

# Agregar remote (GitLab o GitHub)
# Para GitLab:
git remote add origin https://gitlab.com/TU_USUARIO/task-api.git

# Para GitHub:
# git remote add origin https://github.com/TU_USUARIO/task-api.git

# Renombrar rama a main si es necesario
git branch -M main

# Push
git push -u origin main
```

### 1.2 Verificar Archivos Necesarios

Tu proyecto debe tener estos archivos (ya están incluidos):
- ✅ `Procfile` - Comando para ejecutar la app
- ✅ `render.json` - Configuración de build
- ✅ `pom.xml` - Dependencias Maven
- ✅ `.gitlab-ci.yml` - Pipeline CI/CD

---

## 🌐 Paso 2: Crear Cuenta en Render

1. Ve a https://render.com
2. Haz clic en **"Get Started"**
3. Regístrate con:
   - Email y contraseña, O
   - GitHub (recomendado), O
   - GitLab

---

## 🚀 Paso 3: Crear Web Service en Render

### 3.1 Conectar Repositorio

1. En el Dashboard de Render, haz clic en **"New +"**
2. Selecciona **"Web Service"**
3. Conecta tu cuenta de GitLab/GitHub si aún no lo has hecho
4. Busca y selecciona el repositorio `task-api`
5. Haz clic en **"Connect"**

### 3.2 Configurar el Servicio

Llena los siguientes campos:

**Name:** `task-api` (o el nombre que prefieras)

**Region:** `Oregon (US West)` (o el más cercano a ti)

**Branch:** `main`

**Root Directory:** déjalo vacío

**Runtime:** `Java`

**Build Command:**
```bash
./mvnw clean package -DskipTests
```

**Start Command:**
```bash
java -jar target/demo-0.0.1-SNAPSHOT.jar
```

**Instance Type:** `Free`

### 3.3 Variables de Entorno (Opcional)

Si necesitas configurar variables de entorno, haz clic en **"Advanced"** y agrega:

| Key | Value |
|-----|-------|
| `SERVER_PORT` | `10000` |
| `SPRING_PROFILES_ACTIVE` | `prod` |

> **Nota:** Render usa el puerto 10000 por defecto, pero se configura automáticamente con `$PORT`

### 3.4 Crear el Servicio

1. Revisa que todo esté correcto
2. Haz clic en **"Create Web Service"**
3. Render comenzará a desplegar tu aplicación

---

## ⏱️ Paso 4: Esperar el Deployment

Render hará lo siguiente automáticamente:

1. ✅ Clonar tu repositorio
2. ✅ Detectar que es Java/Spring Boot
3. ✅ Ejecutar el build con Maven
4. ✅ Ejecutar los tests (si están en el build)
5. ✅ Crear el JAR ejecutable
6. ✅ Iniciar la aplicación
7. ✅ Asignar una URL pública

**Tiempo estimado:** 3-5 minutos

Puedes ver el progreso en tiempo real en la pestaña **"Logs"**

---

## ✅ Paso 5: Verificar el Deployment

### 5.1 Obtener la URL

Una vez completado, verás un mensaje:
```
==> Your service is live 🎉
```

Tu URL será algo como:
```
https://task-api-xxxx.onrender.com
```

### 5.2 Probar la API

```bash
# Health check
curl https://task-api-xxxx.onrender.com/api/tasks/health

# Crear una tarea
curl -X POST https://task-api-xxxx.onrender.com/api/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Desplegada en Render",
    "description": "Funcionando perfectamente!",
    "completed": false
  }'

# Listar todas las tareas
curl https://task-api-xxxx.onrender.com/api/tasks
```

---

## 🔄 Paso 6: Deploy Automático

¡Ya está todo configurado! Ahora:

1. Haces cambios en tu código local
2. Haces `git commit` y `git push`
3. **Render detecta el push automáticamente**
4. **Despliega la nueva versión**
5. ¡Tu app se actualiza sola!

---

## 📊 Monitoreo y Logs

### Ver Logs en Tiempo Real

1. Ve al Dashboard de Render
2. Haz clic en tu servicio `task-api`
3. Ve a la pestaña **"Logs"**
4. Verás los logs en tiempo real

### Métricas

En la pestaña **"Metrics"** puedes ver:
- CPU usage
- Memory usage
- Request count
- Response times

---

## ⚙️ Configuraciones Avanzadas

### Cambiar el Puerto (si es necesario)

Render usa la variable `$PORT` automáticamente. Si necesitas configurarlo manualmente:

**application.properties:**
```properties
server.port=${PORT:8080}
```

Esto usa el puerto de Render en producción y 8080 en local.

### Agregar Base de Datos PostgreSQL

1. En Render Dashboard, crea un **"PostgreSQL"** database (gratis)
2. Copia la **Internal Database URL**
3. Agrega en Environment Variables:
   - `SPRING_DATASOURCE_URL`: (la URL de PostgreSQL)
   - `SPRING_DATASOURCE_USERNAME`: (usuario)
   - `SPRING_DATASOURCE_PASSWORD`: (contraseña)
4. Actualiza `pom.xml` agregando PostgreSQL driver
5. Redeploy

### Configurar Dominio Personalizado

1. Ve a **"Settings"** → **"Custom Domains"**
2. Agrega tu dominio
3. Configura los DNS según las instrucciones
4. ¡Listo! Tu API estará en tu dominio

---

## 🐛 Troubleshooting

### La aplicación no inicia

**Solución:**
1. Revisa los logs en Render
2. Verifica que el Build Command sea correcto
3. Asegúrate de que `mvnw` tenga permisos de ejecución

### Error: "Port already in use"

**Solución:**
- Asegúrate de usar `${PORT:8080}` en `application.properties`
- Render asigna el puerto automáticamente

### Build falla en Maven

**Solución:**
1. Verifica que `mvnw` esté en el repositorio
2. Prueba localmente: `./mvnw clean package`
3. Revisa las dependencias en `pom.xml`

### La app se "duerme" después de inactividad

**Solución:**
- En el plan gratuito, Render "duerme" la app después de 15 minutos sin requests
- La primera request después de dormirse tomará ~30 segundos
- Considera el plan pago ($7/mes) para mantenerla activa 24/7

---

## 💡 Tips y Mejores Prácticas

1. **Logs detallados:** Usa logging en tu aplicación para debugging
2. **Health checks:** Render verifica `/` por defecto. Considera agregar un endpoint `/health`
3. **Build time:** Los builds pueden tardar. Usa cache cuando sea posible
4. **Variables de entorno:** Nunca pongas secretos en el código
5. **Monitoreo:** Revisa las métricas regularmente

---

## 📈 Siguiente Nivel

Una vez funcionando, considera:

1. **Base de datos persistente** - PostgreSQL en Render (gratis)
2. **Redis para cache** - Mejora el performance
3. **Dominio personalizado** - Más profesional
4. **CI/CD completo** - Automatizar tests antes del deploy
5. **Monitoreo externo** - UptimeRobot para alertas

---

## 🎉 ¡Listo!

Tu API está desplegada y accesible públicamente. 

**URL de tu API:** `https://task-api-xxxx.onrender.com`

**Endpoints disponibles:**
- GET `/api/tasks/health`
- GET `/api/tasks`
- POST `/api/tasks`
- GET `/api/tasks/{id}`
- PUT `/api/tasks/{id}`
- DELETE `/api/tasks/{id}`
- PATCH `/api/tasks/{id}/toggle`
- GET `/api/tasks/status/{completed}`
- GET `/api/tasks/search?title=texto`

---

## 📞 Soporte

- **Documentación oficial:** https://render.com/docs
- **Community:** https://community.render.com
- **Status:** https://status.render.com

---

**¡Felicidades! Tu aplicación está en producción 🚀**
