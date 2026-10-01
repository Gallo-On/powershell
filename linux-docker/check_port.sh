#!/bin/bash
# ==============================================================================
# Script: check_port.sh
# Descripción: Verifica si un puerto TCP está abierto o cerrado en un host.
# Uso: ./check_port.sh <PUERTO> [HOST]
# ==============================================================================

# Colores para la salida en consola
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # Sin color

# 1. Validar que se haya pasado al menos el argumento del puerto
if [ -z "$1" ]; then
    echo -e "${YELLOW}Uso:${NC} $0 <puerto> [host]"
    echo -e "Ejemplos:"
    echo -e "  $0 80"
    echo -e "  $0 443 google.com"
    echo -e "  $0 22 192.168.1.1"
    exit 2
fi

PORT=$1
HOST=${2:-"127.0.0.1"} # Si no se especifica host, usar localhost (127.0.0.1)
TIMEOUT_SEC=2

# 2. Validar que el puerto sea numérico y esté en el rango válido (1 - 65535)
if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
    echo -e "${RED}[ERROR]${NC} El puerto '$PORT' no es válido. Debe ser un número entero entre 1 y 65535."
    exit 2
fi

echo -e "${CYAN}==========================================${NC}"
echo -e "${CYAN}  Verificador de Puertos TCP (Linux/Bash) ${NC}"
echo -e "  Host:   ${YELLOW}$HOST${NC}"
echo -e "  Puerto: ${YELLOW}$PORT${NC}"
echo -e "${CYAN}==========================================${NC}"

# 3. Comprobar si el puerto está abierto o cerrado
# Se utiliza la redirección especial /dev/tcp nativa de Bash con timeout
if timeout $TIMEOUT_SEC bash -c "cat < /dev/null > /dev/tcp/$HOST/$PORT" 2>/dev/null; then
    echo -e "Estado: El puerto ${YELLOW}$PORT${NC} en ${YELLOW}$HOST${NC} está ${GREEN}[ABIERTO]${NC}"
    exit 0
else
    echo -e "Estado: El puerto ${YELLOW}$PORT${NC} en ${YELLOW}$HOST${NC} está ${RED}[CERRADO / NO RESPONDE]${NC}"
    exit 1
fi
