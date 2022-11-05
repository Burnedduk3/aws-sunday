variable "database_information" {
  type = map(object({
    storage_allocation     = number
    engine                 = string
    engine_version         = string
    instance_class         = string
    skip_final_snapshot    = bool
    deletion_protection    = bool
    multi_az               = bool
    vpc_security_group_ids = list(string)
    subnet_ids             = list(string)
    db_name                = string
  }))
  nullable    = false
  description = "RDS data whithou user and password"
}

variable "username" {
  sensitive = true
}

variable "password" {}