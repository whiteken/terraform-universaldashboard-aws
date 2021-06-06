resource "aws_security_group" "RemoteAdmin" {
  name        = "RemoteAdmin"
  description = "Allow Admin traffic from my IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "RDP inbound"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = [var.myIP]
  }

  ingress {
    description      = "WinRM Secure inbound"
    from_port        = 5986
    to_port          = 5986
    protocol         = "tcp"
    cidr_blocks      = [var.myIP]
  }

  ingress {
    description      = "WinRM inbound"
    from_port        = 5985
    to_port          = 5985
    protocol         = "tcp"
    cidr_blocks      = [var.myIP]
  }

  ingress {
    description      = "Ping"
    from_port        = 8
    to_port          = 0
    protocol         = "icmp"
    cidr_blocks      = [var.myIP]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "WebProtocols" {
  name        = "WebProtocols"
  description = "Allow Web traffic from my IP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP Web traffic inbound"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.myIP]
  }

  ingress {
    description      = "HTTPS Web traffic inbound"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.myIP]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}