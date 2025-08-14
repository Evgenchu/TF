terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
  required_version = "~> 1.12.2"
}

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
  command      = coalesce(each.value.command, [])
  ports {
    internal = 80
    external = each.value.port
  }
}

