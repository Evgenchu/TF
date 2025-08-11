locals {
  important_containers = {
    for container in var.containers : container.name => container
    if container.important == true
  }
}

data "docker_registry_image" "latest" {
  for_each = local.important_containers
  name     = "${each.value.image}:latest"
}

resource "docker_image" "latest" {
  for_each      = local.important_containers
  name          = data.docker_registry_image.latest[each.key].name
  pull_triggers = [data.docker_registry_image.latest[each.key].sha256_digest]
}
resource "docker_container" "important_container" {
  for_each     = local.important_containers
  name         = "${each.value.name}_container"
  image        = docker_image.latest[each.key].image_id
  network_mode = "bridge"
  lifecycle {
    create_before_destroy = true
  }
  ports {
    internal = 80
    external = each.value.port
  }
}

output "container_names" {
  value       = [for container in docker_container.important_container : container.name]
  description = "container names"
  sensitive   = true
}
