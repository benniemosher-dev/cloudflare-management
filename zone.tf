resource "cloudflare_zone" "zones" {
  for_each = { for zone in local.zones : zone.name => zone }

  account_id = var.cloudflare-config.account-id
  plan       = try(each.value.plan, "free")
  type       = try(each.value.type, "full")
  zone       = each.value.name
}
