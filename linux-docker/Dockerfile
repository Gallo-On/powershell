# Usar una imagen oficial de Ubuntu como base de Linux
FROM ubuntu:22.04

# Evitar prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias útiles (bash, coreutils, netcat, curl, iputils-ping)
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    coreutils \
    netcat-openbsd \
    curl \
    iputils-ping \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Directorio de trabajo en el contenedor
WORKDIR /app

# Copiar el script al contenedor
COPY check_port.sh /app/check_port.sh

# Otorgar permisos de ejecución al script
RUN chmod +x /app/check_port.sh

# Configurar el script como punto de entrada
ENTRYPOINT ["/app/check_port.sh"]
CMD []
