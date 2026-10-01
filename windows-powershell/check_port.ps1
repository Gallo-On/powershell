<#
.SYNOPSIS
    Script: check_port.ps1
    Verifica si un puerto TCP está abierto o cerrado en un host.

.DESCRIPTION
    Script equivalente en PowerShell para comprobar el estado de conectividad de un puerto TCP.

.PARAMETER Port
    Número del puerto TCP a comprobar (1 - 65535). Obligatorio.

.PARAMETER HostName
    Dirección IP o nombre de host a verificar. Por defecto: 127.0.0.1.

.PARAMETER TimeoutMs
    Tiempo máximo de espera en milisegundos para la conexión. Por defecto: 2000 ms.

.EXAMPLE
    .\check_port.ps1 -Port 80
.EXAMPLE
    .\check_port.ps1 -Port 443 -HostName "google.com"
.EXAMPLE
    .\check_port.ps1 22 192.168.1.1
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Ingrese el número de puerto (1 - 65535)")]
    [ValidateRange(1, 65535)]
    [int]$Port,

    [Parameter(Position = 1)]
    [string]$HostName = "127.0.0.1",

    [int]$TimeoutMs = 2000
)

# Configurar salida en UTF-8 para visualización correcta de caracteres especiales
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "  Verificador de Puertos TCP (PowerShell) " -ForegroundColor Cyan
Write-Host "  Host:   $HostName" -ForegroundColor Yellow
Write-Host "  Puerto: $Port" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan

# Intentar la conexión TCP utilizando System.Net.Sockets.TcpClient con soporte para Timeout
$tcpClient = New-Object System.Net.Sockets.TcpClient

try {
    # Iniciar conexión asíncrona para controlar el timeout de forma precisa
    $asyncResult = $tcpClient.BeginConnect($HostName, $Port, $null, $null)
    $connectionCompleted = $asyncResult.AsyncWaitHandle.WaitOne($TimeoutMs, $false)

    if ($connectionCompleted -and $tcpClient.Connected) {
        $tcpClient.EndConnect($asyncResult)
        Write-Host "Estado: El puerto $Port en $HostName está " -NoNewline
        Write-Host "[ABIERTO]" -ForegroundColor Green
        exit 0
    } else {
        Write-Host "Estado: El puerto $Port en $HostName está " -NoNewline
        Write-Host "[CERRADO / NO RESPONDE]" -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "Estado: El puerto $Port en $HostName está " -NoNewline
    Write-Host "[CERRADO / ERROR]" -ForegroundColor Red
    Write-Verbose "Detalle del error: $($_.Exception.Message)"
    exit 1
}
finally {
    $tcpClient.Close()
    $tcpClient.Dispose()
}
