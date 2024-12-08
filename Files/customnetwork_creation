#Create vpc
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "ProjectK_vpc"
  }
}

#Create subnets in vpc
#Create public subnet1
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "public_subnet"
  }
}
#Create public subnet2
resource "aws_subnet" "public2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  tags ={
    Name = "public_subnet-2"
  }
}

#Create private subnet1
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2a"
  tags = {
    Name = "private_subnet"
  }
}
#Create private subnet2
resource "aws_subnet" "private2" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-west-2b"
  tags = {
    Name = "private_subnet-2"
  }
}

#Create internet gateway 
resource "aws_internet_gateway" "dev_ig" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "My_gateway"
  }
}

#Create elsticip for NAT gateway
resource "aws_eip" "dev_nat" {
  domain = "vpc"
}

#Create Nat gateway
resource "aws_nat_gateway" "dev_nat" {
  allocation_id = aws_eip.dev_nat.id
  subnet_id = aws_subnet.public.id
  tags = {
    Name = "My_Nat_gateway"
  }
}

#update route table
    #public Route table : Routes to the internet through internet gateway
    #private Route table : Routes to the internet through the nat gateway

#public Route table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Public_RT"
  }
}

resource "aws_route" "public_internet" {
  route_table_id = aws_route_table.public_route.id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.dev_ig.id
 
}

#Private Route table
resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "Private_RT"
    }
}

resource "aws_route" "priavte_nat" {
  route_table_id = aws_route_table.private_route.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.dev_nat.id
}


#Association with public Route tables
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public_route.id
}
resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.public_route.id
}

#Association with private subnets
resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private_route.id
}
resource "aws_route_table_association" "private2" {
  subnet_id = aws_subnet.private2.id
  route_table_id = aws_route_table_association.private.id
}


#Security group for EC2 instances
resource "aws_security_group" "ec2_sg" {
  name = "ec2_security_group"
  description = "Allow inbound SSh and HTTP traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#EC2 instance in the public subnet 
resource "aws_instance" "ec2_instance" {
  ami = ""
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  key_name = "projectK"

  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "My_EC2"
  }
}