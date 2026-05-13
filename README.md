# IaC Lab

Homelab de **Infrastructure as Code**: Proxmox como hipervisor, Terraform para provisionar máquinas, com vista a Ansible e Kubernetes. Repositório pensado para ser partilhado publicamente — sem segredos no código.

---

## O que está implementado

**Terraform** em `terraform/` cria uma VM Linux a partir de um template no Proxmox (cloud-init, rede estática, chave SSH). O resto da stack está em construção.

---

## Estrutura

```
iac-lab/
├── README.md
├── .gitignore
└── terraform/
    ├── main.tf
    ├── provider.tf
    ├── variables.tf
    ├── terraform.tfvars.example
    └── .terraform.lock.hcl
```

Crie localmente `terraform/terraform.tfvars` (a partir do `.example`) — esse ficheiro **não** deve ser commitado. Em breve: pastas `ansible/`, `kubernetes/` e `scripts/`.

---

## Requisitos

- [Terraform](https://www.terraform.io/downloads) instalado  
- Proxmox VE com template pronto para clone  
- Utilizador com **API token** no Proxmox (secret só no `terraform.tfvars`)

---

## Como correr

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars: URL da API, nó, template, rede e secret do token

terraform init
terraform plan
terraform apply
```

Variáveis declaradas em `variables.tf`; valores reais no `terraform.tfvars`. O ficheiro `terraform.tfvars.example` serve de modelo para quem clona o repositório.

---

## Proxmox (resumo)

Num lab típico: repositórios *No-Subscription*, utilizador de automação, token de API em **Datacenter → Permissions → API Tokens**, permissões no caminho certo do cluster. Ajuste nomes e roles ao seu ambiente.

---

## Próximos passos

Mais variáveis no Terraform, Ansible nos nós, bootstrap de Kubernetes e um workload de exemplo — commits incrementais à medida que o projeto avança.
