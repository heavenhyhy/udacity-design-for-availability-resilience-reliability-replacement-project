# resource "aws_security_group" "primary_database" {
#   name   = "UDARR-Database"
#   vpc_id = aws_vpc.primary.id

#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   provider = aws.active
# }

# resource "aws_security_group" "secondary_database" {
#   name   = "UDARR-Database"
#   vpc_id = aws_vpc.secondary.id

#   ingress {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
  
#   provider = aws.standby
# }

# resource "aws_db_subnet_group" "primary" {
#   name       = "main"
#   subnet_ids = [aws_subnet.primary_private.id, aws_subnet.primary_private_1.id]
  
#   provider = aws.active
# }

# resource "aws_db_subnet_group" "secondary" {
#   name       = "main"
#   subnet_ids = [aws_subnet.secondary_private.id, aws_subnet.secondary_private_1.id]
  
#   provider = aws.standby
# }

# resource "aws_db_instance" "primary" {
#   identifier             = "primary"
#   instance_class         = "db.t3.micro"
#   allocated_storage      = 5
#   engine                 = "mysql"
#   engine_version         = "8.0"
#   db_name                = "udacity"
#   username               = "test"
#   password               = "123456aA"
#   db_subnet_group_name   = aws_db_subnet_group.primary.name
#   vpc_security_group_ids = [aws_security_group.primary_database.id]
#   skip_final_snapshot    = true
#   multi_az               = true
#   backup_retention_period     = 1
  
#   provider = aws.active
# }


# resource "aws_db_instance" "secondary" {
#   identifier             = "secondary"
#   replicate_source_db    = aws_db_instance.primary.arn
#   instance_class         = "db.t3.micro"
#   engine                 = "mysql"
#   engine_version         = "8.0"
#   password               = "123456aA"
#   db_subnet_group_name   = aws_db_subnet_group.secondary.name
#   vpc_security_group_ids = [aws_security_group.secondary_database.id]
#   skip_final_snapshot    = true
#   multi_az               = true
#   backup_retention_period     = 1
  
#   provider = aws.standby
# }