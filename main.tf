provider "aws" {
  region = "us-west-1"
}

resource "aws_security_group" "instance_security_group" {
  name        = "instance_security_group"
  description = "Allow SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance_security_group"
  }
}

resource "aws_instance" "jenkins" {
  ami           = "ami-0c55b159cbfafe1f0" # centos 7
  instance_type = "t2.large"

  tags = {
    Name = "jenkins"
  }

  block_device {
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = 20
  }

  vpc_security_group_ids = [aws_security_group.instance_security_group.id]

  key_name = "gitops"

  associate_public_ip_address = true
}

resource "aws_instance" "sonarqube" {
  ami           = "ami-0c55b159cbfafe1f0" # centos 7
  instance_type = "t2.large"

  tags = {
    Name = "sonarqube"
  }

  block_device {
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = 20
  }

  vpc_security_group_ids = [aws_security_group.instance_security_group.id]

  key_name = "gitops"

  associate_public_ip_address = true
}

resource "aws_instance" "nexus" {
  ami           = "ami-0c55b159cbfafe1f0" # centos 7
  instance_type = "t2.large"

  tags = {
    Name = "nexus"
  }

  block_device {
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = 20
  }

  vpc_security_group_ids = [aws_security_group.instance_security_group.id]

  key_name = "gitops"

  associate_public_ip_address = true
}
resource "aws_instance" "minikube" {
  ami           = "ami-0b6b955c5c7f7d092" # ubuntu 22
  instance_type = "t2.large"

  tags = {
    Name = "minikube"
  }

  block_device {
    device_name = "/dev/sdb"
    volume_type = "gp2"
    volume_size = 20
  }

  vpc_security_group_ids = [aws_security_group.instance_security_group.id]

  key_name = "gitops"

  associate_public_ip_address = true
}

output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "sonarqube_public_ip" {
  value = aws_instance.sonarqube.public_ip
}

output "nexus_public_ip" {
  value = aws_instance.nexus.public_ip
}

output "minikube_public_ip" {
  value = aws_instance.minikube.public_ip
}
