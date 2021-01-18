resource "aws_key_pair" "key" {
  key_name   = "london-ec2"
  public_key = file(var.pub_key)
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


resource "aws_instance" "ec2" {
  count                  = var.instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg-http-https-ssh.id]
  #  iam_instance_profile   = "EC2SecretAccessRole"

  provisioner "remote-exec" {
    inline = ["echo 'Waiting for server to be initialized...'"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.pr_key)
      host        = self.public_ip
    }

  }
#  provisioner "local-exec" {
#    command = <<EOT
#	export ANSIBLE_HOST_KEY_CHECKING=False
#	ansible-playbook \
#		-i ../ansible/inventory/aws_ec2.yml \
#		-u ubuntu \
#		--private-key ${var.pr_key} \
#		 ../ansible/test.yml
#	EOT
# }
  tags = {
    Name = format("Server-%d", count.index)
  }
  subnet_id = var.public_subnets.* [count.index]
}


