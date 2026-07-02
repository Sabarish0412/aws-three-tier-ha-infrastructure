# Bastion Host Key Pair
resource "aws_key_pair" "bastion" {
  key_name   = "${var.project_name}-bastion-key"
  public_key = var.bastion_public_key

  tags = {
    Name = "${var.project_name}-bastion-key"
  }
}

# Bastion Host EC2 Instance
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_1_id
  vpc_security_group_ids      = [var.bastion_sg_id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.bastion.key_name

  tags = {
    Name = "${var.project_name}-bastion"
  }
}
