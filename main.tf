provider "aws" {
  region = "us-east-1"
}

# 1. IAM ROLE: Cấp "thẻ bài" cho Server nói chuyện với AWS SSM
resource "aws_iam_role" "ssm_role" {
  name = "devops-project-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# Gán quyền quản lý từ xa (SSM) vào Role vừa tạo
resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Tạo Profile để gắn Role vào máy chủ EC2
resource "aws_iam_instance_profile" "ssm_profile" {
  name = "devops-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

# 2. SECURITY GROUP: Firewall bảo mật cao
resource "aws_security_group" "devops_sg" {
  name        = "devops-app-sg"
  description = "Only allow Web Port 8080"

  # CHỈ mở cổng 8080 cho người dùng (Bỏ cổng 22 SSH)
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Cho phép Server đi ra ngoài Internet (để tải Docker, kéo Image)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3. EC2 INSTANCE: Máy chủ chạy App
resource "aws_instance" "devops_server" {
  ami           = "ami-0df7a207adb8948a7" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"             # Free Tier

  # Gắn Profile SSM và Security Group
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  # Tự động cài đặt Docker khi vừa khởi tạo
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install docker.io -y
              sudo systemctl start docker
              sudo systemctl enable docker
              sudo usermod -aG docker ubuntu
              EOF

  tags = {
    Name = "DevOps-Prod-Server-SSM"
  }
}

# Đưa ra địa chỉ IP để bạn truy cập Web
output "app_url" {
  value = "http://${aws_instance.devops_server.public_ip}:8080"
}