data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "streisand" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "citius"
  associate_public_ip_address = true
  private_ip = "10.0.0.12"

  subnet_id = aws_subnet.streisand.id

  vpc_security_group_ids = [
    aws_security_group.streisand.id
  ]

  tags = {
    Name = "streisand instance"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.streisand.public_ip} > private_ip.txt"
  }

  provisioner "local-exec" {
    command = "./provision.sh"
  }

}
