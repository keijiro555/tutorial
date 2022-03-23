# EC2インスタンスの作成


resource "aws_instance" "sample_web_server" {

  ami                    = "ami-0abaa5b0faf689830" # Amazon Linux 2
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.sample_subnet.id
  vpc_security_group_ids = [aws_security_group.sample_sg.id]
  key_name               = "aws-user"

  tags = {
    Name = "web"
  }
}

