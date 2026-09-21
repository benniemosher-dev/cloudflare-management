# A single reusable Access policy — "allow these emails" — applied to
# every app in local.tunnel_apps. All of these are personal, single-user
# apps behind the tunnels in tunnels.tf, so one shared policy is enough;
# split per-app if an app ever needs a different audience.
resource "cloudflare_zero_trust_access_policy" "personal" {
  account_id = var.cloudflare-config.account-id
  name       = "personal-allow"
  decision   = "allow"

  include = [
    for email in var.cloudflare-config.allowed-emails : {
      email = { email = email }
    }
  ]
}

resource "cloudflare_zero_trust_access_application" "tunnel_apps" {
  for_each = local.tunnel_apps

  account_id       = var.cloudflare-config.account-id
  name             = each.key
  domain           = "${each.value.subdomain}.${each.value.zone}"
  type             = "self_hosted"
  session_duration = "24h"

  policies = [
    { id = cloudflare_zero_trust_access_policy.personal.id }
  ]
}
