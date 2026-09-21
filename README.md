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

`cloudflare.auto.tfvars` needs an `allowed-emails` list on `cloudflare-config` as of the
tunnels/Access work below — add it to the Keybase secrets file if it's missing:

```hcl
cloudflare-config = {
  # ...existing keys...
  allowed-emails = ["you@example.com"]
}
```

The API token in that file also needs **Cloudflare Tunnel: Edit** and
**Access: Apps and Policies: Edit** permissions in addition to whatever it
already has — add them in the dashboard under My Profile → API Tokens if
`plan`/`apply` comes back with an authorization error on the new resources.

### Self-hosted apps behind a Cloudflare Tunnel

Each entry in `local.tunnel_apps` (`locals.tf`) provisions a full
Tunnel + Access setup for one app — no dashboard clicking. After `apply`:

```bash
terraform output -json tunnel_tokens
```

gives you the per-app connector token to seal into that app's Kubernetes
namespace (see `homelab-gitops`'s `apps/<app>/RUNBOOK.md` for the
`kubectl`/`kubeseal` step).

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
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~> 5.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 5.16.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [cloudflare_account.ours](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/account) | resource |
| [cloudflare_dns_record.tunnel_apps](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_email_routing_catch_all.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/email_routing_catch_all) | resource |
| [cloudflare_zero_trust_access_application.tunnel_apps](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_application) | resource |
| [cloudflare_zero_trust_access_policy.personal](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_access_policy) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared.apps](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared_config.apps](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zero_trust_tunnel_cloudflared_config) | resource |
| [cloudflare_zone.zones](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone) | resource |
| [random_id.tunnel_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [cloudflare_zero_trust_tunnel_cloudflared_token.apps](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zero_trust_tunnel_cloudflared_token) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cloudflare-config"></a> [cloudflare-config](#input\_cloudflare-config) | The config to connect Terraform to Cloudflare | <pre>object({<br/>    account-id     = optional(string, null)<br/>    api-token      = string<br/>    cidrs          = list(string)<br/>    allowed-emails = list(string)<br/>  })</pre> | n/a | yes |
| <a name="input_config"></a> [config](#input\_config) | The config for your organization in Github. | <pre>object({<br/>    org-name = string<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_tunnel_tokens"></a> [tunnel\_tokens](#output\_tunnel\_tokens) | Per-app cloudflared connector tokens, keyed by the same key as<br/>local.tunnel\_apps. Sensitive — never commit the raw value. Retrieve<br/>with `terraform output -json tunnel_tokens`, then seal it into the<br/>target app's namespace as the `cloudflared-credentials` secret's<br/>`tunnel-token` key (see e.g. homelab-gitops's apps/<app>/RUNBOOK.md). |
<!-- END_TF_DOCS -->
