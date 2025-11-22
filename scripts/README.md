# Scripts de Deploy

Este diretório contém scripts automatizados para deploy e rollback da aplicação DevOps Flask.

## 📋 Scripts Disponíveis

### 1. deploy.sh
Script principal de deploy que automatiza o processo de atualização da aplicação.

**O que faz:**
- Para e remove containers antigos
- Baixa a imagem Docker mais recente do GitHub Container Registry
- Inicia um novo container com a versão atualizada
- Verifica se a aplicação está rodando corretamente

**Como usar:**
```bash
./scripts/deploy.sh
```

**Pré-requisitos:**
- Docker instalado e rodando
- Acesso ao GitHub Container Registry (ghcr.io)

---

### 2. rollback.sh
Script de rollback para reverter para uma versão anterior em caso de problemas.

**O que faz:**
- Para e remove o container com problema
- Baixa a imagem de uma versão específica (por commit hash)
- Inicia o container com a versão anterior
- Verifica se está funcionando

**Como usar:**
```bash
./scripts/rollback.sh <commit-hash>
```

**Exemplo:**
```bash
# Reverter para o commit ec6d1ec
./scripts/rollback.sh ec6d1ec
```

**Como encontrar o hash do commit:**
1. Vá até o GitHub Actions
2. Veja os workflows bem-sucedidos anteriores
3. Copie o hash curto do commit (7 caracteres)

---

## 🔧 Configuração

Ambos os scripts usam as seguintes configurações:

- **Imagem:** `ghcr.io/fe1984lms/devops-project`
- **Container:** `devops-flask-container`
- **Porta:** `5001:5000` (host:container)
- **Ambiente:** Production

---

## 📚 Fluxo de Deploy Completo

### Deploy Normal:
1. Desenvolvedor faz push do código
2. GitHub Actions roda CI/CD pipeline
3. Se testes passarem, imagem é publicada
4. Executar `./scripts/deploy.sh` no servidor
5. Aplicação atualizada automaticamente

### Em caso de problema:
1. Identificar último commit estável
2. Executar `./scripts/rollback.sh <commit-hash>`
3. Aplicação volta para versão anterior
4. Investigar e corrigir o problema
5. Fazer novo deploy quando corrigido

---

## ⚠️ Notas Importantes

- Os scripts verificam se Docker está rodando
- Containers antigos são sempre removidos antes de criar novos
- A flag `--restart unless-stopped` garante que o container reinicia após reboot
- Logs podem ser visualizados com: `docker logs devops-flask-container`

---

## 🧪 Testando os Scripts

Antes de usar em produção, teste localmente:
```bash
# 1. Testar deploy
./scripts/deploy.sh

# 2. Verificar se está rodando
curl http://localhost:5001

# 3. Testar rollback (use um hash real)
./scripts/rollback.sh a2524be

# 4. Verificar novamente
curl http://localhost:5001/health
```