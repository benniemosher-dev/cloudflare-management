# cloudflare-management

![CI Terraform](https://github.com/benniemosher-dev/cloudflare-management/actions/workflows/ci-terraform.yml/badge.svg)

🗿 TF managing our Cloudflare organization. 🗿

## 📜 Usage:

### To retrieve Cloudflare secrets:

Reach out to [@benniemosher](https://keybase.io/benniemosher) on Keybase and get access to his secrets repo then:

```bash
git clone keybase://private/benniemosher/secrets
ln -s $HOME/Code/personal/secrets/cloudflare.auto.tfvars ./cloudflare.auto.tfvars
```

- To install dependencies needed run:
  ```bash
  brew bundle install
  ```
- To initialize Terraform in this folder:
  ```bash
  task infra:init
  ```
- To update modules and providers in this folder:
  ```bash
  task init -- -upgrade
  ```
- To validate the module in this folder:
  ```bash
  task infra:validate
  ```
- To plan the infrastructure in this folder:
  ```bash
  task infra:plan
  ```
- To plan specific resources of infrastructure in this folder:
  ```bash
  task infra:plan -- -target='cloudflare_record.this'
  ```
- To apply the infrastructure in this folder:
  ```bash
  task infra:apply
  ```
- To apply specific resources of infrastructure in this folder:
  ```bash
  task infra:apply -- -target='cloudflare_record.this'
  ```
- To destroy the infrastructure in this folder:
  ```bash
  task infra:destroy
  ```
- To destroy specific resources of infrastructure in this folder:
  ```bash
  task infra:destroy -- -target='cloudflare_record.this'
  ```

### 🆒 Extras:

- To find all the automation available in this folder:
  ```bash
  task --list-all
  ```
- To estimate the cost of the infrastructure in this folder:
  ```bash
  task infra:cost
  ```
- To update the documentation in this folder:
  ```bash
  task infra:docs
  ```
- To lint the Terraform in this folder:
  ```bash
  task infra:lint
  ```
- To validate security in this folder:
  ```bash
  task infra:sec
  ```

## 📋 Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 3.29.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_zone.zones](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare-config"></a> [cloudflare-config](#input\_cloudflare-config) | The config to connect Terraform to Cloudflare | <pre>object({<br>    account-id = optional(string, null)<br>    api-token  = string<br>    cidrs      = list(string)<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
