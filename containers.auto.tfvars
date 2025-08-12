containers = [
  {
    image     = "python"
    name      = "python"
    important = true
    port      = 80
    command   = ["sleep", "50000"]
  },
  {
    image     = "nginx"
    name      = "nginx"
    important = true
    port      = 8080
  }
]
