resource "aws_vpc" "office-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "office-vpc"
  }
}

resource "aws_internet_gateway" "igw-office-main" {
  vpc_id = aws_vpc.office-vpc.id

  tags = {
    Name = "igw-office-main"
  }
}

resource "aws_eip" "ngw-office-1a" {
  public_ipv4_pool     = "amazon"
  network_border_group = var.region


  tags = {
    Name = " ngw-office-1a"
  }
}

resource "aws_nat_gateway" "ngw-office-1a" {
  allocation_id     = aws_eip.ngw-office-1a.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.office_subnets["public-1a"].id

  tags = {
    Name = "ngw-office-1a"
  }
}

resource "aws_eip" "ngw-office-1b" {
  public_ipv4_pool     = "amazon"
  network_border_group = var.region


  tags = {
    Name = " ngw-office-1b"
  }
}

resource "aws_nat_gateway" "ngw-office-1b" {
  allocation_id     = aws_eip.ngw-office-1b.id
  connectivity_type = "public"
  subnet_id         = aws_subnet.office_subnets["public-1b"].id

  tags = {
    Name = "ngw-office-1b"
  }
}

resource "aws_eip" "bastion_instance_eip" {
  public_ipv4_pool     = "amazon"
  network_border_group = var.region

  tags = {
    Name       = "bastion-eip"
    Desription = "bastion EC2 instance EIP"
  }
}
