variable "vpc_ip" {
  type        = string
  description = "Its the IP that should be used by the network"
  default     = "192.168.0.0/16"
  nullable    = false
}

variable "subnets" {
  type = list(object({
    subnet            = string
    availability_zone = string
  }))
  default     = []
  description = "The subnets that will compose the network"
  nullable    = false
}

variable "environment" {
  type        = string
  default     = "prod"
  description = "The environment of the objects that are being created"
  nullable    = false
}