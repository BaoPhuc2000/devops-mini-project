1️⃣ Dự án DevOps for beginer 🌱
 • Pipeline CI/CD bằng GitHub Actions
 • Script tự động build & triển khai
 • Docker hóa một ứng dụng web đơn giản
 • Script giám sát log
 • Dashboard giám sát sức khỏe server

# 🚀 DevOps Mini Project: CI/CD Pipeline & Monitoring

Dự án này thực hiện quy trình tự động hóa tích hợp và triển khai (CI/CD) cho một ứng dụng Node.js cơ bản bằng Docker và GitHub Actions.

## 🏗 Cấu trúc dự án
- **app/**: Chứa mã nguồn ứng dụng Node.js và Dockerfile.
- **.github/workflows/**: Chứa file cấu hình GitHub Actions (CI/CD).
- **monitor.sh**: Script Bash để giám sát trạng thái container.

## 🛠 Công nghệ sử dụng
- **Docker**: Đóng gói ứng dụng thành Image.
- **GitHub Actions**: Tự động Build và Push Image lên Docker Hub.
- **Docker Hub**: Lưu trữ Image.
- **Bash Script**: Giám sát vận hành (Monitoring).

## 🚀 Quy trình CI/CD
1. Mỗi khi có lệnh `git push` lên nhánh `main`, GitHub Actions sẽ tự động kích hoạt.
2. Hệ thống thực hiện Build Docker Image từ thư mục `/app`.
3. Đăng nhập và đẩy (Push) Image lên Docker Hub với tag `:latest`.

## 📈 Hướng dẫn giám sát (Monitoring)
Để chạy script giám sát trên môi trường Linux/WSL:
1. Cấp quyền thực thi:
   ```bash
   chmod +x monitor.sh
