# 1. Cria um Orçamento (Budget) para a sua Assinatura do Azure
resource "azurerm_consumption_budget_subscription" "alerta_estudos" {
  name            = "orcamento-laboratorios-estudo"
  subscription_id = "/subscriptions/68fe6443-14b1-45ff-87c7-c0603675c480" # Seu ID de Assinatura

  amount     = 10 # Limite total do orçamento em Reais (R$ 10,00)
  time_grain = "Monthly" # Reseta o contador todo início de mês

  time_period {
    start_date = "2026-09-01T00:00:00Z" # Data de início do monitoramento (Ano atual)
    end_date   = "2028-12-31T00:00:00Z" # Data de término do monitoramento
  }

  # Alerta 1: Envia e-mail quando os gastos reais atingirem 80% do limite (R$ 8,00)
  notification {
    enabled        = true
    threshold      = 80.0
    operator       = "EqualTo"
    threshold_type = "Actual"

    contact_emails = [
      "rafael.dev13@gmail.com" # e-mail para receber o aviso
    ]
  }

  # Alerta 2: Envia e-mail se a PREVISÃO do Azure indicar que você vai atingir 100% (R$ 10,00)
  notification {
    enabled        = true
    threshold      = 100.0
    operator       = "EqualTo"
    threshold_type = "Forecasted" # Avisa antes do custo real acontecer se a tendência for gastar mais

    contact_emails = [
      "rafael.dev13@gmail.com"
    ]
  }
}
