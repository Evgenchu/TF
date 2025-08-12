variable "containers" {
  type = list(object({
    image     = string
    name      = string
    important = optional(bool)
    port      = number
    command   = optional(list(string))
  }))
  validation {
    condition     = alltrue([for container in var.containers : container.port < 65535 && container.port > 0])
    error_message = "Port numer should be between 0 and 65535!"
  }
}
