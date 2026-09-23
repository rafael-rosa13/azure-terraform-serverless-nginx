# Infraestrutura como Código (IaC): Implantação de Servidor Web Serverless no Azure com Terraform

Este repositório contém o código necessário para provisionar uma infraestrutura web automatizada no **Microsoft Azure** utilizando **Terraform**. O projeto foi desenhado para expor um servidor web Nginx público utilizando **Azure Container Instances (ACI)**, aplicando conceitos modernos de arquitetura ágil e serverless.

## 🚀 Arquitetura do Projeto

A infraestrutura foi modelada de forma totalmente declarativa através do Terraform:
*   **Provedor Azure (azurerm):** Conexão direta com a API do Azure para gerenciamento do ciclo de vida dos recursos.
*   **Resource Group:** Agrupamento lógico para organização e governança do laboratório.
*   **Random String:** Geração de sufixos pseudoaleatórios dinâmicos para evitar colisões globais de nomes de domínio (DNS).
*   **Azure Container Instance (ACI):** Provisionamento de um container isolado rodando a imagem oficial do **Nginx**, configurado com recursos mínimos de hardware (0.5 CPU / 1.5GB RAM) otimizando custos e eficiência de capacidade.

## 🛠️ Desafios de Engenharia & Solução de Problemas (Troubleshooting)

O desenvolvimento deste laboratório simulou um cenário real de restrições em nuvens públicas, exigindo adaptações rápidas de arquitetura:

1. **Restrição de SKU de Máquinas Virtuais (`SkuNotAvailable`):** Inicialmente estruturado para rodar em uma VM Linux tradicional (`Standard_B1s`), o ambiente enfrentou restrições severas de capacidade física na região `eastus`.
2. **Políticas de Cota de Assinatura (`OperationNotAllowed`):** Ao tentar migrar para regiões alternativas e novas famílias de VMs (como a série B v2 e D v3), a assinatura barrou a implantação devido a limites de Cores zerados por padrão em contas novas de teste.
3. **A Solução Arquitetural (Pivot para Containers):** Para contornar os limites físicos de Compute do provedor sem gerar custos excessivos ou depender de suporte técnico, a arquitetura foi pivotada para **Serverless Containers (ACI)**. Essa mudança permitiu contornar as restrições de cotas e entregou uma solução moderna, rápida e imune à falta de estoque físico de VMs.
4. **Gerenciamento de Estado do Terraform (`drift`):** Durante o processo de migração de recursos, o estado local do Terraform (`terraform.tfstate`) foi sincronizado e resetado via CLI, mitigando conflitos de referências inválidas de rede (`InvalidResourceReference`).

## 🔧 Como Replicar este Projeto

### Pré-requisitos
*   Possuir o [Terraform](https://terraform.io) instalado localmente.
*   Possuir a [Azure CLI](https://microsoft.com) instalada.
*   Uma conta ativa no Microsoft Azure.

### Passo a Passo

1. **Clonar o repositório:**
   ```bash
   git clone https://github.com/rafael-rosa13/azure-terraform-serverless-nginx.git
   cd /azure-terraform-serverless-nginx
   ```

2. **Autenticar na sua conta Azure:**
   ```bash
   az login
   ```

3. **Inicializar o Terraform:**
   ```bash
   terraform init
   ```

4. **Planejar e Aplicar a Infraestrutura:**
   ```bash
   terraform apply -auto-approve
   ```

5. **Acessar o serviço:**
   Ao final da execução, o Terraform exibirá no terminal o `endereco_do_site`. Copie a URL e cole no seu navegador.

6. **Destruir os recursos (Custo Zero):**
   Para evitar cobranças residuais após a validação do laboratório, execute:
   ```bash
   terraform destroy -auto-approve
   ```

---
Projeto desenvolvido por **Rafael da Cunha Rosa** como parte da preparação técnica para a carreira de Analista Cloud / DevOps.
Certificações Atuais: **AZ-900 Microsoft Azure Fundamentals** | **LPI Linux Essentials**.
