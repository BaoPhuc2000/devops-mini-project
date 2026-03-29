#!/bin/bash
# Script hiển thị Dashboard đơn giản

while true; do
    clear
    echo "====================================================="
    echo "   🚀 DEVOPS MONITORING DASHBOARD - $(date)  "
    echo "====================================================="
    echo ""
    
    # 1. Kiểm tra tài nguyên Container
    echo "📊 TRẠNG THÁI CONTAINER:"
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.Status}}"
    
    echo ""
    # 2. Kiểm tra tài nguyên Server (Host)
    echo "🖥️ TÀI NGUYÊN SERVER:"
    echo "RAM Free: $(free -h | grep Mem | awk '{print $4}')"
    echo "Disk Usage: $(df -h / | tail -1 | awk '{print $5}')"
    
    echo ""
    echo "Bấm [CTRL+C] để thoát Dashboard."
    sleep 5 # Cập nhật sau mỗi 5 giây
done