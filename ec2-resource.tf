//Ec2 instance
resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami
  instance_type = var.instancetype

  subnet_id = aws_subnet.public-subnet.id
  key_name = var.key_name
  security_groups = [ "${aws_security_group.allow_tls.id}"]

  tags = {
    Name = "IaC-poc"
  }
}