# Sử dụng môi trường Node.js tí hon (alpine)
FROM node:18-alpine

# Thư mục làm việc trong Container
WORKDIR /usr/src/app

# Copy file cấu hình vào trước để cài đặt thư viện
COPY package*.json ./
RUN npm install

# Copy toàn bộ code vào trong Container
COPY . .

# Mở cổng 3000 để truy cập từ bên ngoài
EXPOSE 3000

# Lệnh khởi chạy ứng dụng
CMD [ "node", "app.js" ]