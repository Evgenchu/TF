locals {
  important_containers = {
    for container in var.containers : container.name => merge(container, {
      container_image = (
        length(split(":", container.image)) == 1 ? "${container.image}:latest" : container.image
      )
    })
    if container.important == true
  }
}

resource "docker_image" "important_image" {
  for_each = local.important_containers
  name     = split(":", each.value.container_image)[0]
}

resource "docker_container" "important_container" {
  for_each     = local.important_containers
  name         = "${each.value.name}_container"
  image        = docker_image.important_image[each.key].image_id
  network_mode = "bridge"
  ports {
    internal = 80
    external = each.value.port
  }
}
