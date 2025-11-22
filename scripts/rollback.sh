#!/bin/bash

# Script de Rollback - DevOps Flask App
# Este script reverte o deploy para uma versão anterior em caso de problemas

echo "⏪ Iniciando processo de rollback..."

# Configurações
CONTAINER_NAME="devops-flask-container"
PORT="5001:5000"

# Verificar se foi passado um hash de commit
if [ -z "$1" ]; then
  echo "❌ Erro: É necessário especificar o hash do commit para rollback"
  echo "Uso: ./rollback.sh <commit-hash>"
  echo "Exemplo: ./rollback.sh a2524be"
  exit 1
fi

COMMIT_HASH=$1
IMAGE_NAME="ghcr.io/fe1984lms/devops-project:$COMMIT_HASH"

echo "📌 Fazendo rollback para commit: $COMMIT_HASH"

# 1. Parar container atual
echo "📦 Parando container atual..."
docker stop $CONTAINER_NAME 2>/dev/null || true

# 2. Remover container atual
echo "🗑️  Removendo container atual..."
docker rm $CONTAINER_NAME 2>/dev/null || true

# 3. Baixar a imagem da versão específica
echo "⬇️  Baixando imagem da versão anterior..."
docker pull $IMAGE_NAME

# 4. Iniciar container com a versão anterior
echo "🔄 Iniciando container com versão anterior..."
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
  echo "✅ Rollback concluído com sucesso!"
  echo "📱 Aplicação revertida para versão: $COMMIT_HASH"
  echo "📱 Disponível em: http://localhost:5001"
  docker ps | grep $CONTAINER_NAME
else
  echo "❌ Erro: Container não está rodando após rollback"
  exit 1
fi