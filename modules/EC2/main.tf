resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.subnet_id
  security_groups = [var.security_group_id]
  associate_public_ip_address = var.associate_public_ip_address
  user_data = var.user_data
}

resource "aws_key_pair" "key_pair" {
  key_name = var.key_name
  public_key = file(var.key_file_path)
}