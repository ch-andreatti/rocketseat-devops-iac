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
├── environments/
│   │
│   ├── prod/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   │
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   │
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars
│
├── variables.tf
├── outputs.tf
└── main.tf
```

**Description:**

- **modules/**: Contains reusable Terraform modules that encapsulate specific infrastructure components (e.g., networking, compute, storage).

- **environments/**: Holds environment-specific configurations (e.g., development, staging, production). Each environment has its own directory with configuration files.

- **variables.tf**: Defines global variables used across all environments.

- **outputs.tf**: Defines output values that can be accessed after applying the Terraform configuration.

- **main.tf**: The main entry point for the Terraform configuration.
