#!/bin/bash

echo "正在启动 DevOps 套件..."
docker-compose up -d

echo "等待服务启动..."
sleep 30

echo "服务状态:"
docker-compose ps

echo ""
echo "访问地址:"
echo "GitLab: http://localhost 或 http://gitlab.example.com"
echo "Jenkins: http://localhost:8080 或 http://jenkins.example.com"
echo "Harbor: http://localhost:8081 或 http://harbor.example.com"