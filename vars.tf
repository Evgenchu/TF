variable "containers" {
  type = list(object({
    image     = string
    name      = string
    important = bool
    port      = number
  }))
}
