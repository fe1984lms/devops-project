# Usa uma imagem base do Python 3.11
FROM python:3.11-slim

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de dependências primeiro (para aproveitar cache do Docker)
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia o resto dos arquivos da aplicação
COPY . .

# Expõe a porta 5000 (porta padrão do Flask)
EXPOSE 5000

# Define variável de ambiente para o Flask
ENV FLASK_APP=app.py

# Comando para iniciar a aplicação
CMD ["python", "app.py"]