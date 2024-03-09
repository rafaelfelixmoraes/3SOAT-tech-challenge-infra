# 3SOAT-tech-challenge-infra
Repository for Azure Function IaC of Tech Challenge from FIAP 3SOAT - Pós Tech

## Objetivo
O repositório armazena o IaC Terraform da Azure Function com build e deploy automatizado via Github Actions, utilizando a integração com Terraform Cloud e Azure CLI e Azure OpenID.

A pipeline do Actions está configurada da seguinte forma:
- Para PRs: Executa a validação e build do script terraform, até a etapa "terraform plan"
- Commits na Main: A etapa da implantação via "terraform apply" ocorre somente quando há um evento de Push na branch "Main"
- A cada execução da pipeline, ele gera automaticamente um comentário no PR com o status da execução de cada passo

Abaixo algumas documentações utilizadas nessa configuração:

- https://github.com/Azure/actions
- https://learn.microsoft.com/pt-br/azure/app-service/deploy-github-actions?tabs=applevel%2Caspnetcore
- https://learn.microsoft.com/pt-br/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows
- https://learn.microsoft.com/pt-br/entra/workload-id/workload-identity-federation-create-trust?pivots=identity-wif-apps-methods-azp#entity-type-examples
- https://learn.microsoft.com/pt-br/azure/azure-portal/get-subscription-tenant-id
- https://github.com/Azure/login?tab=readme-ov-file#login-with-openid-connect-oidc-recommended


