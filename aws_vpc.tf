# VPCの作成

resource "aws_vpc" "sample_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC1"
  }
}

#サブネットの作成
resource "aws_subnet" "sample_subnet" {
  vpc_id                  = aws_vpc.sample_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Sub1"
  }
}

#サブネットの作成
resource "aws_subnet" "sample_subnet2" {
  vpc_id            = aws_vpc.sample_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "Sub2"
  }
}



# インターネットゲートウェイの作成

resource "aws_internet_gateway" "sample_igw" {
  vpc_id = aws_vpc.sample_vpc.id
}

# プライベート用ルートテーブルの作成

resource "aws_route_table" "sample_rtb" {
  vpc_id = aws_vpc.sample_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_igw.id
  }
}


# パブリックのサブネットにルートテーブルを紐づけ

resource "aws_route_table_association" "sample_rt_assoc" {
  subnet_id      = aws_subnet.sample_subnet.id
  route_table_id = aws_route_table.sample_rtb.id
}

# プライベートのサブネットにルートテーブルを紐づけ

resource "aws_route_table_association" "sample_rt_assoc2" {
  subnet_id      = aws_subnet.sample_subnet2.id
  route_table_id = aws_route_table.nat_rtb.id
}

# セキュリティグループの作成

resource "aws_security_group" "sample_sg" {
  name   = "sample-sg"
  vpc_id = aws_vpc.sample_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



