resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.environment}-default-key-pair"
  public_key = var.ec2_public_key
}

resource "aws_instance" "instances" {
  for_each                    = var.ec2_information
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = each.value.instance_type
  security_groups             = [each.value.default_security_group]
  associate_public_ip_address = true
  subnet_id                   = each.value.subnet_id
  key_name                    = aws_key_pair.ec2_key.key_name

  tags = each.value.tags
}