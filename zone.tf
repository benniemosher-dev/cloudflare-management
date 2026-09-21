resource "cloudflare_zone" "zones" {
  for_each = { for zone in local.zones : zone.name => zone }

  account = {
    id = var.cloudflare-config.account-id
  }
  name = each.value.name
  type = try(each.value.type, "full")
  # No `plan` argument in provider v5 — it's now a computed,
  # read-only attribute on this resource (subscription changes moved
  # elsewhere in the API). Was previously set here but silently ignored
  # since the ~> 5.0 bump; this resource has been out of sync with the
  # pinned provider version since then. account_id/zone were also
  # renamed to account.id/name in the same schema change.
}
