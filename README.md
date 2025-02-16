# Multi-environment infrastructure configuration

## Objective

This project is the resolution of the IaC challenge of [Rocketseat](https://www.rocketseat.com.br/?utm_source=google&utm_medium=cpc&utm_campaign=lead&utm_term=perpetuo&utm_content=institucional-lead-home-texto-lead-brandkws-none-none-institucional-none-none-br-google&gad_source=1&gclid=EAIaIQobChMIs8m544a0iwMViiNECB0YPQXREAAYASAAEgIAn_D_BwE) DevOps track.

The project consists of developing a distributed infrastructure in three environments (prod, staging and dev) using Terraform. Each environment requires specific configurations such as different instance sizes, environment variables and network configurations.

## Technical description

### Folder structure

```
├── modules/
│   │
│   ├── resource_a/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── resource_b/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf 
│   │
│   └── ...
│
├── main.tf
├── provider.tf
└── variables.tf
```

**Description:**

- **modules/**: Contains reusable Terraform modules that encapsulate specific infrastructure components (e.g., networking, compute, storage).

- **main.tf**: The main entry point for the Terraform configuration.

- **provider.tf**: File that defines the communication with cloud provider.

- **variables.tf**: File that defines global variables used across all environments.
