locals {
  zones = [
    {
      name = "benniemosher.dev"
    }
  ]

  # Self-hosted apps exposed to the internet via a dedicated Cloudflare
  # Tunnel each — one cloudflared sidecar per app pod in the homelab k3s
  # cluster, no inbound port ever opened. Add an entry here instead of
  # clicking through the Zero Trust dashboard; see tunnels.tf/access.tf
  # for what gets provisioned per entry.
  tunnel_apps = {
    lifttrace = {
      zone      = "benniemosher.dev"
      subdomain = "lifttrace"
      # cloudflared talks to the app over loopback inside the shared pod.
      service = "http://localhost:3002"
    }
  }
}
