#### Primary
resource "aws_key_pair" "primary_ssh_key" {
  key_name   = "Primary SSH Key"
  public_key = file("../../.ssh/id_rsa.pub")

  provider = aws.active
}

resource "aws_instance" "primary_db_access" {
  depends_on = [
    aws_cloudformation_stack.primary, aws_cloudformation_stack.secondary
  ]

  ami           = "ami-06c68f701d8090592" // al2023-ami-2023.5.20240701.0-kernel-6.1-x86_64
  instance_type = "t3.micro"
  key_name      = aws_key_pair.primary_ssh_key.key_name
  vpc_security_group_ids = [aws_cloudformation_stack.primary.outputs["ApplicationSecurityGroup"]]
  subnet_id = split(", ", aws_cloudformation_stack.primary.outputs["PrivateSubnets"])[0]

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
  depends_on = [
    aws_cloudformation_stack.primary, aws_cloudformation_stack.secondary
  ]
  
  ami           = "ami-0604d81f2fd264c7b" // al2023-ami-2023.5.20240701.0-kernel-6.1-x86_64
  instance_type = "t3.micro"
  key_name      = aws_key_pair.secondary_ssh_key.key_name
  vpc_security_group_ids = [aws_cloudformation_stack.secondary.outputs["ApplicationSecurityGroup"]]
  subnet_id = split(", ", aws_cloudformation_stack.secondary.outputs["PrivateSubnets"])[0]

  tags = {
    Name = "DbAccess"
  }

  provider = aws.standby
}