# 🪟 Método 2: Windows con PowerShell (`check_port.ps1`)

Este script en PowerShell permite verificar si un puerto TCP está abierto o cerrado en un host utilizando `System.Net.Sockets.TcpClient` con timeout asíncrono.

---

## 📁 Archivos
* [`check_port.ps1`](file:///c:/Users/gaela/Desktop/9no/Gestión%20de%20seguridad%20de%20la%20información/1oct26/windows-powershell/check_port.ps1): Script principal de PowerShell.

---

## 🚀 Cómo ejecutar en PowerShell

```powershell
Set-Location "c:\Users\gaela\Desktop\9no\Gestión de seguridad de la información\1oct26\windows-powershell"

# 1. Probar puerto 443 (Abierto)
powershell -ExecutionPolicy Bypass -File .\check_port.ps1 443 google.com

# 2. Probar puerto 80 (Abierto)
powershell -ExecutionPolicy Bypass -File .\check_port.ps1 80 google.com

# 3. Probar puerto 65432 (Cerrado)
powershell -ExecutionPolicy Bypass -File .\check_port.ps1 65432 127.0.0.1
```
