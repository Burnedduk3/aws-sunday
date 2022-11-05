resource "aws_db_subnet_group" "default" {
  for_each   = var.database_information
  name       = "${each.key}-database"
  subnet_ids = each.value.subnet_ids

  tags = {
    Name = "${each.key}-database"
  }
}

resource "aws_db_instance" "default" {
  for_each             = var.database_information
  allocated_storage    = each.value.storage_allocation
  db_name              = each.value.db_name
  identifier           = each.key
  engine               = each.value.engine
  engine_version       = each.value.engine_version
  instance_class       = each.value.instance_class
  username             = var.username
  password             = var.password
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.default[each.key].name
}