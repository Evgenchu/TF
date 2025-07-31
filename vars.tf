variable "containers" {
  type = list(object({
    image = string
    name  = string
    apply = bool
    port  = number
  }))
}
