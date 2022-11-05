variable "ec2_information" {
  type = map(
    object({
      instance_type          = string
      tags                   = map(string)
      default_security_group = string
      subnet_id              = string
    })
  )
  description = "ec2 data to create instances"
}

variable "environment" {
  type        = string
  nullable    = false
  description = "In which environment are you working"
  default     = "default"
}

variable "ec2_public_key" {
  type        = string
  description = "EC2 instance public key"
  nullable    = false
  sensitive   = true
}