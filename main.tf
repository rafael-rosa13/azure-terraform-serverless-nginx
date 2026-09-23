terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Gera um sufixo aleatório para garantir que sua URL seja única no mundo
resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}

# 2. Cria o Grupo de Recursos
resource "azurerm_resource_group" "rg" {
  name     = "rg-projeto-container"
  location = "eastus" 
}

# 3. Cria o Container Group (Injeta o Nginx direto sem precisar de VM)
resource "azurerm_container_group" "container" {
  name                = "aci-nginx-portfolio"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  ip_address_type     = "Public"
  
  # CORREÇÃO AQUI: Agora usamos o recurso random_string criado acima
  dns_name_label      = "portfolio-cloud-${random_string.random.result}" 
  
  os_type             = "Linux"

  container {
    name   = "nginx-web"
    image  = "nginx:latest" 
    cpu    = "0.5"          
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

# Outputs para exibir no terminal ao final do processo
output "endereco_do_site" {
  value = "http://${azurerm_container_group.container.fqdn}"
}

output "ip_do_site" {
  value = azurerm_container_group.container.ip_address
}