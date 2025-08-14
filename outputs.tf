output "container_names" {
  value       = [for container in docker_container.important_container : container.name]
  description = "container names"
}
