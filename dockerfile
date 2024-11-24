# --- Etapa 1: Construcción del Frontend ---
    FROM node:18 AS frontend-builder

    # Crear el directorio de trabajo para el frontend
    WORKDIR /app
    
    # Copiar archivos de configuración y dependencias del frontend
    COPY package.json package-lock.json ./
     


    # Instalar dependencias del frontend
    RUN npm install
    

    # Instalas vite
    RUN npm install vite --save-dev
    
    # Copiar todo el código fuente del frontend
    COPY . ./
    
    # Construir el frontend
    RUN npm run build
    
    # --- Etapa 2: Configuración del Backend ---
   


    FROM python:3.9-slim

    # Instalar dependencias necesarias para OpenCV
    RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0

    WORKDIR /app

    # Copiar el archivo de dependencias y hacer install
    COPY requirements.txt ./
    RUN pip install --no-cache-dir -r requirements.txt

    # Copiar el resto de los archivos del backend
    COPY . ./

    # Exponer el puerto
    EXPOSE 5000

    CMD ["python", "src/utils/app.py"]

