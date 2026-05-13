# IaC Lab - Proxmox to Kubernetes

## Português

### Descrição
Este projeto documenta a implementação de um laboratório de infraestrutura automatizada (Infrastructure as Code), partindo da instalação do Proxmox VE até à orquestração de um cluster Kubernetes.

### Estrutura do Projeto
- `terraform/`: Ficheiros de configuração para provisionamento de VMs e Templates.
- `ansible/`: Playbooks para automação de configurações e instalação de software.
- `kubernetes/`: Manifestos e configurações para gestão do cluster.
- `scripts/`: Scripts auxiliares para manutenção e automação rápida.

### Objetivos
- Automatizar a criação de máquinas virtuais via API do Proxmox.
- Utilizar o Ansible para gestão de configuração e segurança dos nós.
- Implementar um cluster Kubernetes funcional para deploy de aplicações.

---

## English

### Description
This project documents the implementation of an automated infrastructure lab (Infrastructure as Code), from the initial Proxmox VE setup to Kubernetes cluster orchestration.

### Project Structure
- `terraform/`: Configuration files for VM and Template provisioning.
- `ansible/`: Playbooks for configuration management and software installation.
- `kubernetes/`: Manifests and configurations for cluster management.
- `scripts/`: Helper scripts for maintenance and quick automation.

### Objectives
- Automate virtual machine creation via Proxmox API.
- Use Ansible for node configuration management and hardening.
- Deploy a functional Kubernetes cluster for application hosting.
