resource "aws_vpc" "primary" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Primary"
  }

  provider = aws.active
}

resource "aws_vpc" "secondary" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Secondary"
  }

  provider = aws.standby
}

resource "aws_subnet" "primary_private" {
 vpc_id     = aws_vpc.primary.id
 cidr_block = "10.0.1.0/24"
 
 tags = {
   Name = "Private Subnet Primary VPC"
 }
 
  provider = aws.active
}

resource "aws_subnet" "secondary_private" {
 vpc_id     = aws_vpc.secondary.id
 cidr_block = "10.0.1.0/24"
 
 tags = {
   Name = "Private Subnet Secondary VPC"
 }
 
  provider = aws.standby
}
