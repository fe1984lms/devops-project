# Projeto DevOps - Flask API

API REST simples desenvolvida em Python Flask para demonstração de práticas DevOps.

## 📋 Descrição

Este projeto faz parte da Fase 1 do curso de DevOps e implementa:
- Pipeline de Integração Contínua (CI)
- Infraestrutura como Código (IaC)
- Testes automatizados

## 🚀 Tecnologias

- Python 3.x
- Flask 3.0.0
- GitHub Actions (CI/CD)

## 📦 Instalação
```bash
pip install -r requirements.txt
```

## ▶️ Execução
```bash
python app.py
```

A API estará disponível em: http://localhost:5000

## 🔗 Endpoints

- `GET /` - Retorna mensagem de boas-vindas
- `GET /health` - Verifica status da aplicação