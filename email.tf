resource "cloudflare_email_routing_catch_all" "this" {
  for_each = { for zone in local.zones : zone.name => zone }

  zone_id = cloudflare_zone.zones[each.key].id
  name    = "${replace(each.value.name, ".", "-")}-catch-all"
  enabled = true

  matcher {
    type = "all"
  }

  action {
    type  = "forward"
    value = ["${replace(each.value.name, ".", "+")}@gmail.com"]
  }
}
