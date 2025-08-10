containers = [
  {
    image     = "nextcloud"
    name      = "nextcloud"
    important = true
    port      = 80
  },
  {
    image     = "nginx"
    name      = "nginx"
    important = true
    port      = 8080
  }
]
