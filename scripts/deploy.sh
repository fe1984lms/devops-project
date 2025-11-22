#!/bin/bash

# Script de Deploy - DevOps Flask App
# Este script automatiza o processo de deploy da aplicação containerizada

echo "🚀 Iniciando processo de deploy..."

# Configurações
IMAGE_NAME="ghcr.io/fe1984lms/devops-project:latest"
CONTAINER_NAME="devops-flask-container"
PORT="5001:5000"

# 1. Parar container antigo (se existir)
echo "📦 Parando container antigo..."
docker stop $CONTAINER_NAME 2>/dev/null || true

# 2. Remover container antigo (se existir)
echo "🗑️  Removendo container antigo..."
docker rm $CONTAINER_NAME 2>/dev/null || true

# 3. Baixar a imagem mais recente
echo "⬇️  Baixando imagem Docker mais recente..."
docker pull $IMAGE_NAME

# 4. Iniciar novo container
echo "🔄 Iniciando novo container..."
docker run -d \
  --name $CONTAINER_NAME \
  -p $PORT \
  -e FLASK_APP=app.py \
  -e FLASK_ENV=production \
  --restart unless-stopped \
  $IMAGE_NAME

# 5. Verificar se está rodando
echo "✅ Verificando status do container..."
sleep 2

if docker ps | grep -q $CONTAINER_NAME; then
  echo "✅ Deploy concluído com sucesso!"
  echo "📱 Aplicação disponível em: http://localhost:5001"
  docker ps | grep $CONTAINER_NAME
else
  echo "❌ Erro: Container não está rodando"
  exit 1
fi