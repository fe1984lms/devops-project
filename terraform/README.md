# Infraestrutura como Código - Terraform

Este diretório contém os scripts Terraform para provisionar a infraestrutura AWS necessária para o projeto DevOps.

## 📋 Recursos Provisionados

- **EC2 Instance**: Servidor Ubuntu t2.micro para hospedar a aplicação Flask
- **Security Group**: Firewall configurado para permitir:
  - Porta 5000 (aplicação Flask)
  - Porta 22 (SSH)

## 🔧 Pré-requisitos

- Terraform instalado (>= 1.0)
- AWS CLI configurado com credenciais
- Conta AWS ativa

## 🚀 Como Usar

### 1. Inicializar Terraform
```bash
cd terraform
terraform init
```

### 2. Validar configuração
```bash
terraform validate
```

### 3. Ver plano de execução
```bash
terraform plan
```

### 4. Aplicar infraestrutura
```bash
terraform apply
```

### 5. Destruir infraestrutura
```bash
terraform destroy
```

## 📊 Outputs

Após o `terraform apply`, serão exibidos:
- `instance_id`: ID da instância EC2
- `instance_public_ip`: IP público para acesso
- `security_group_id`: ID do Security Group

## ⚙️ Variáveis

- `aws_region`: Região AWS (default: us-east-1)
- `ami_id`: ID da AMI Ubuntu
- `instance_type`: Tipo da instância (default: t2.micro)