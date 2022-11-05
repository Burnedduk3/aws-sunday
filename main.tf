module "networking" {
  source = "./modules/networking"
  vpc_ip = "192.168.0.0/16"
  subnets = [
    {
      subnet            = "192.168.0.0/24"
      availability_zone = "us-east-1a"
    },
    {
      subnet            = "192.168.1.0/24"
      availability_zone = "us-east-1b"
    },
    {
      subnet            = "192.168.2.0/24"
      availability_zone = "us-east-1a"
    },
    {
      subnet            = "192.168.3.0/24"
      availability_zone = "us-east-1b"
    }
  ]
  environment = local.environment
}

module "computing" {
  source     = "./modules/computing"
  depends_on = [module.networking]
  ec2_information = {
    Jenkins = {
      instance_type = "t2.micro"
      tags = {
        Name = "Jenkins"
      }
      default_security_group = module.networking.security_group_id
      subnet_id              = module.networking.subnet_ids[0]
    }
    front_end = {
      instance_type = "t2.micro"
      tags = {
        Name = "front-end"
      }
      default_security_group = module.networking.security_group_id
      subnet_id              = module.networking.subnet_ids[1]
    }
    back_end = {
      instance_type = "t2.micro"
      tags = {
        Name = "back-end"
      }
      default_security_group = module.networking.security_group_id
      subnet_id              = module.networking.subnet_ids[2]
    }
  }

  environment    = local.environment
  ec2_public_key = file("./keys/aws-sunday.pub")
}

module "databases" {
  source = "./modules/database"
  depends_on = [module.networking]
  database_information = {
    postgres = {
      storage_allocation     = 10
      engine                 = "postgres"
      engine_version         = "13.7"
      instance_class         = "db.t3.micro"
      skip_final_snapshot    = true
      deletion_protection    = false
      multi_az               = false
      vpc_security_group_ids = [module.networking.security_group_id]
      subnet_ids             = module.networking.subnet_ids
      db_name                = "analytics"
    }
  }
  password = "password1"
  username = "username1"
}