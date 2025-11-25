# Script de verificación para el proyecto Task API
# Este script verifica que todo esté configurado correctamente

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Verificación del Proyecto Task API" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Verificar Java
Write-Host "Verificando Java..." -ForegroundColor Yellow
try {
    $javaVersion = java -version 2>&1 | Select-String "version" | ForEach-Object { $_ -replace '.*"(.*)".*', '$1' }
    Write-Host "  Java instalado: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "  Java no está instalado" -ForegroundColor Red
}
Write-Host ""

# Verificar Maven Wrapper
Write-Host "Verificando Maven..." -ForegroundColor Yellow
if (Test-Path ".\mvnw.cmd") {
    Write-Host "  Maven Wrapper encontrado" -ForegroundColor Green
} else {
    Write-Host "  Maven Wrapper no encontrado" -ForegroundColor Red
}
Write-Host ""

# Verificar estructura del proyecto
Write-Host "Verificando estructura del proyecto..." -ForegroundColor Yellow
$requiredFiles = @(
    "pom.xml",
    ".gitlab-ci.yml",
    "src\main\java\com\example\demo\DemoApplication.java",
    "src\main\java\com\example\demo\controller\TaskController.java",
    "src\main\java\com\example\demo\model\Task.java",
    "src\main\java\com\example\demo\repository\TaskRepository.java",
    "src\main\java\com\example\demo\service\TaskService.java",
    "src\test\java\com\example\demo\controller\TaskControllerTest.java",
    "src\test\java\com\example\demo\service\TaskServiceTest.java"
)

$allFilesExist = $true
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "  $file" -ForegroundColor Green
    } else {
        Write-Host "  $file NO ENCONTRADO" -ForegroundColor Red
        $allFilesExist = $false
    }
}
Write-Host ""

# Verificar .gitignore
Write-Host "Verificando .gitignore..." -ForegroundColor Yellow
if (Test-Path ".gitignore") {
    $content = Get-Content ".gitignore" -Raw
    if ($content -match "\*.pem" -and $content -match "\*.key") {
        Write-Host "  .gitignore configurado correctamente" -ForegroundColor Green
    } else {
        Write-Host "  .gitignore existe pero puede necesitar ajustes" -ForegroundColor Yellow
    }
} else {
    Write-Host "  .gitignore no encontrado" -ForegroundColor Red
}
Write-Host ""

# Compilar el proyecto
Write-Host "Intentando compilar el proyecto..." -ForegroundColor Yellow
try {
    $null = .\mvnw.cmd clean compile -q 2>&1
    Write-Host "  Compilación exitosa" -ForegroundColor Green
} catch {
    Write-Host "  Error en la compilación" -ForegroundColor Red
}
Write-Host ""

# Resumen
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  Resumen" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
if ($allFilesExist) {
    Write-Host "Todos los archivos necesarios están presentes" -ForegroundColor Green
} else {
    Write-Host "Faltan algunos archivos" -ForegroundColor Red
}
Write-Host ""

Write-Host "Próximos pasos:" -ForegroundColor Cyan
Write-Host "1. Revisar GITLAB_SETUP.md para configurar GitLab"
Write-Host "2. Crear instancia EC2 en AWS"
Write-Host "3. Configurar variables CI/CD en GitLab"
Write-Host "4. Hacer git push para activar el pipeline"
Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
