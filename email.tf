resource "cloudflare_email_routing_catch_all" "this" {
  for_each = { for zone in local.zones : zone.name => zone }

  zone_id = cloudflare_zone.zones[each.key].id
  name    = "${replace(each.value.name, ".", "-")}-catch-all"
  enabled = true

  # matcher{}/action{} blocks became matchers/actions list attributes in
  # provider v5 — this resource was also out of sync with the pinned
  # ~> 5.0 provider (see zone.tf/account.tf).
  matchers = [
    {
      type = "all"
    }
  ]

  actions = [
    {
      type  = "forward"
      value = ["${replace(each.value.name, ".", "+")}@gmail.com"]
    }
  ]
}
