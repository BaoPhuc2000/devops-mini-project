#!/bin/bash
CONTAINER_NAME="my-web-app"

echo "--- Đang quét Log của $CONTAINER_NAME ---"

# Lấy 20 dòng log cuối cùng và tìm chữ ERROR (không phân biệt hoa thường)
ERROR_COUNT=$(docker logs --tail 20 $CONTAINER_NAME 2>&1 | grep -i "ERROR" | wc -l)

if [ $ERROR_COUNT -gt 0 ]; then
    echo "🚨 CẢNH BÁO: Phát hiện $ERROR_COUNT lỗi trong Log!"
    docker logs --tail 5 $CONTAINER_NAME
else
    echo "✅ Log sạch, ứng dụng đang chạy ổn định."
fi