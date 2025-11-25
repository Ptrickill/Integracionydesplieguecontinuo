#!/bin/bash

# Script de verificación para el proyecto Task API
# Este script verifica que todo esté configurado correctamente

echo "========================================="
echo "  Verificación del Proyecto Task API"
echo "========================================="
echo ""

# Verificar Java
echo "✓ Verificando Java..."
if command -v java &> /dev/null
then
    JAVA_VERSION=$(java -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo "  Java instalado: $JAVA_VERSION"
else
    echo "  ❌ Java no está instalado"
fi
echo ""

# Verificar Maven
echo "✓ Verificando Maven..."
if [ -f "./mvnw" ]; then
    echo "  Maven Wrapper encontrado"
else
    echo "  ❌ Maven Wrapper no encontrado"
fi
echo ""

# Verificar estructura del proyecto
echo "✓ Verificando estructura del proyecto..."
REQUIRED_FILES=(
    "pom.xml"
    ".gitlab-ci.yml"
    "src/main/java/com/example/demo/DemoApplication.java"
    "src/main/java/com/example/demo/controller/TaskController.java"
    "src/main/java/com/example/demo/model/Task.java"
    "src/main/java/com/example/demo/repository/TaskRepository.java"
    "src/main/java/com/example/demo/service/TaskService.java"
    "src/test/java/com/example/demo/controller/TaskControllerTest.java"
    "src/test/java/com/example/demo/service/TaskServiceTest.java"
)

ALL_FILES_EXIST=true
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ $file"
    else
        echo "  ❌ $file NO ENCONTRADO"
        ALL_FILES_EXIST=false
    fi
done
echo ""

# Verificar .gitignore
echo "✓ Verificando .gitignore..."
if [ -f ".gitignore" ]; then
    if grep -q "*.pem" .gitignore && grep -q "*.key" .gitignore; then
        echo "  ✓ .gitignore configurado correctamente"
    else
        echo "  ⚠️  .gitignore existe pero puede necesitar ajustes"
    fi
else
    echo "  ❌ .gitignore no encontrado"
fi
echo ""

# Resumen
echo "========================================="
echo "  Resumen"
echo "========================================="
if [ "$ALL_FILES_EXIST" = true ]; then
    echo "✅ Todos los archivos necesarios están presentes"
else
    echo "❌ Faltan algunos archivos"
fi
echo ""

echo "📋 Próximos pasos:"
echo "1. Revisar GITLAB_SETUP.md para configurar GitLab"
echo "2. Crear instancia EC2 en AWS"
echo "3. Configurar variables CI/CD en GitLab"
echo "4. Hacer git push para activar el pipeline"
echo ""
echo "========================================="
