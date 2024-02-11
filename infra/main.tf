resource "aws_key_pair" "web-kez" {
    key_name = "${var.name}-kez"
    public_key = var.pub-key
  
}
resource "aws_vpc" "net-main" {
    cidr_block = var.vpc-cidr
    enable_dns_hostnames = true

    tags = {
      Name = "${var.name}-vpc"
    }
  
}

resource "aws_subnet" "public" {
   
    vpc_id = aws_vpc.net-main.id
    cidr_block = "10.23.128.0/24"
    availability_zone = var.availability-zone

    tags = {
      Name = "${var.name}-pb"
    }
       
}

resource "aws_subnet" "private" {
    vpc_id = aws_vpc.net-main.id
    cidr_block = "10.23.64.0/18"
    availability_zone =  var.availability-zone

    tags = {
      Name = "${var.name}-pr"
    }
       
}

resource "aws_eip" "nat" {
  domain   = "vpc"

}

resource "aws_nat_gateway" "natgw" {
   
    allocation_id = aws_eip.nat.id
    subnet_id = aws_subnet.public.id
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.net-main.id
  
}

resource "aws_route_table" "rt-public" {
    vpc_id = aws_vpc.net-main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
}

resource "aws_route_table" "rt-private" {
   
    vpc_id = aws_vpc.net-main.id
    

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgw.id
    }
  
}

resource "aws_route_table_association" "pub-rtassoc" {
   
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.rt-public.id
}

resource "aws_route_table_association" "pri-rtassoc" {
 
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.rt-private.id
}

resource "aws_security_group" "web_sg" {
  name        = "webadm-security-group"
  description = "Security group for web-site"
  vpc_id = aws_vpc.net-main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_network_interface" "web-nic" {
 
  subnet_id       = aws_subnet.public.id
  private_ips     = ["10.23.128.100"]
  security_groups = [aws_security_group.web_sg.id]
}


resource "aws_instance" "web" {
  for_each = var.instance-name
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = var.instance-type
  key_name = aws_key_pair.web-kez.key_name 
  subnet_id = aws_subnet.public.id
  availability_zone = var.availability-zone
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.web_sg.id]

#   network_interface {
#     device_index = 0
#     network_interface_id = aws_network_interface.web-nic.id
#   }

  tags = {
    Name = "${each.value}-server"
  }

  user_data = <<-EOF
          #!/bin/bash
          sudo apt-get update
          sudo apt-get install -y apache2
          sudo systemctl start apache2
          sudo systemctl enable apache2
          EOF
}
