# infra

This project contains the configuration for my cloud infrastructure,
for which I use Terraform, an open-source infrastructure-as-code tool.

Secret files are stored in the repository using [git-crypt](https://github.com/AGWA/git-crypt)
to perform in-place transparent file encryption.

## Terraform Resource Overview

The configuration is split into Terraform modules.

Each module contains the following base files:

| File           | Description                                                                               |
| -------------- | ----------------------------------------------------------------------------------------- |
| `main.tf`      | Terraform requirements and shared module resources                                        |
| `outputs.tf`   | [Terraform Outputs](https://www.terraform.io/docs/language/values/outputs.html)           |
| `variables.tf` | [Terraform Input Variables](https://www.terraform.io/docs/language/values/variables.html) |

### Core

Core infrastructure.

| File                                    | Description                                  |
| --------------------------------------- | -------------------------------------------- |
| [`cloudflare.tf`](./core/cloudflare.tf) | Common Cloudflare DNS records and Page Rules |
