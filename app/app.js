const http = require('http');

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello! Day la du an DevOps dau tay cua toi.\n');
});

// Chạy ứng dụng tại cổng 3000
server.listen(3000, '0.0.0.0', () => {
  console.log('Server dang chay tai port 3000');
});