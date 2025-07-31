containers = [
  {
    image = "nextcloud"
    name  = "nextcloud"
    apply = true
    port  = 80
  },
  {
    image = "nginx"
    name  = "nginx"
    apply = true
    port  = 8080
  }
]
