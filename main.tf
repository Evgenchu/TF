resource "docker_container" "nginx" {
  for_each = { for idx, container in var.containers : idx => container }
  name     = each.value.name
  image    = each.value.image
  ports {
    internal = 80
    external = 8000
  }
}
