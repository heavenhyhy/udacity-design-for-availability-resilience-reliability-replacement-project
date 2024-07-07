#### Primary
resource "aws_key_pair" "primary_ssh_key" {
  key_name   = "Primary SSH Key"
  public_key = file("../../.ssh/id_rsa.pub")

  provider = aws.active
}

resource "aws_instance" "primary_db_access" {
  ami           = "ami-07832e309d3f756c8" // al2023-ami-2023.5.20240701.0-kernel-6.1-arm64
  instance_type = "t3.micro"
  key_name      = aws_key_pair.primary_ssh_key.key_name
  vpc_security_group_ids = [aws_cloudformation_stack.primary.outputs["ApplicationSecurityGroup"]]
  subnet_id = aws_cloudformation_stack.primary.outputs["ApplicationSecurityGroup"]

  tags = {
    Name = "DbAccess"
  }

  provider = aws.active
}

#### Secondary
resource "aws_key_pair" "secondary_ssh_key" {
  key_name   = "Secondary SSH Key"
  public_key = file("../../.ssh/id_rsa.pub")

  provider = aws.standby
}

resource "aws_instance" "secondary_db_access" {
  ami           = "ami-07832e309d3f756c8" // al2023-ami-2023.5.20240701.0-kernel-6.1-arm64
  instance_type = "t3.micro"
  key_name      = aws_key_pair.secondary_ssh_key.key_name
  vpc_security_group_ids = [aws_cloudformation_stack.secondary.outputs["ApplicationSecurityGroup"]]
  subnet_id = aws_cloudformation_stack.secondary.outputs["ApplicationSecurityGroup"]

  tags = {
    Name = "DbAccess"
  }

  provider = aws.standby
}