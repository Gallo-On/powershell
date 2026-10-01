# 🐧 Método 1: Linux en Docker (`check_port.sh`)

Este script en Bash permite verificar si un puerto TCP está abierto o cerrado en un host utilizando la redirección `/dev/tcp` nativa de Bash y la utilidad `timeout`.

---

## 📁 Archivos
* [`check_port.sh`](file:///c:/Users/gaela/Desktop/9no/Gestión%20de%20seguridad%20de%20la%20información/1oct26/linux-docker/check_port.sh): Shell script principal.
* [`Dockerfile`](file:///c:/Users/gaela/Desktop/9no/Gestión%20de%20seguridad%20de%20la%20información/1oct26/linux-docker/Dockerfile): Imagen de Ubuntu configurada con el script.

---

## 🚀 Cómo ejecutar desde PowerShell

### Opción A: Ejecución directa con contenedor Ubuntu (Recomendado)
```powershell
Set-Location "c:\Users\gaela\Desktop\9no\Gestión de seguridad de la información\1oct26\linux-docker"

# 1. Probar puerto 443 (Abierto)
docker run --rm -v "${PWD}:/app" -w /app ubuntu:latest bash check_port.sh 443 google.com

# 2. Probar puerto 80 (Abierto)
docker run --rm -v "${PWD}:/app" -w /app ubuntu:latest bash check_port.sh 80 google.com

# 3. Probar puerto 65432 (Cerrado)
docker run --rm -v "${PWD}:/app" -w /app ubuntu:latest bash check_port.sh 65432 127.0.0.1
```

### Opción B: Construyendo con Dockerfile
```powershell
Set-Location "c:\Users\gaela\Desktop\9no\Gestión de seguridad de la información\1oct26\linux-docker"

# 1. Construir la imagen
docker build -t port-checker .

# 2. Ejecutar
docker run --rm port-checker 443 google.com
docker run --rm port-checker 65432 127.0.0.1
```
