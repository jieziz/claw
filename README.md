# ClawCloud 活动页面



一个展示 ClawCloud 产品和活动信息的动态网站。



## 功能特点

- 产品展示和分类

- 限时优惠活动

- Looking Glass 测试

- 自动部署系统



## 技术栈



### 前端

- HTML5

- TailwindCSS - 响应式设计

- 原生 JavaScript - 交互逻辑



### 后端

- Node.js - 运行环境

- Express - API 服务

- SQLite3 - 数据存储

- PM2 - 进程管理



## 项目结构



├── public/ # 静态资源目录

│ ├── assets/ # 图片等资源

│ ├── css/ # 样式文件

│ ├── js/ # JavaScript 文件

│ ├── index.html # 主页面

│ └── lg.html # Looking Glass 页面

├── config/ # 配置文件目录

│ └── database.js # 数据库配置

├── server.js # 服务器入口文件

├── init.sql # 数据库初始化脚本

└── package.json # 项目依赖配置



## 部署流程



### 1. 环境要求

- Node.js 18+

- PM2 (进程管理器)

- Web 服务器 (如 Nginx, OpenResty)

- SQLite3



### 2. 服务器准备

```bash
# 创建目录
mkdir -p /www/wwwroot/claw.ink
mkdir -p /opt/clawcloud

# 安装全局依赖
npm install -g pm2
```



### 3. Nginx 配置

```nginx
server {
    listen 80;
    server_name claw.ink;  # 替换为你的域名

    # 静态文件目录
    location / {
        root /www/wwwroot/claw.ink;
        index index.html;
        try_files $uri $uri/ /index.html;
    }

    # API 反向代理
    location /api/ {
        proxy_pass http://127.0.0.1:3000/;  # Node.js 后端服务
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```



```bash
# 测试配置
nginx -t

# 重启 Nginx
nginx -s reload
```



### 4. GitHub Actions 自动部署

项目使用 GitHub Actions 实现自动部署。

需要在 GitHub 仓库设置以下 Secrets：

- `SERVER_IP`: 服务器 IP 地址

- `SERVER_USERNAME`: SSH 用户名

- `SERVER_PASSWORD`: SSH 密码



自动部署流程：

1. 推送代码到 main 分支触发部署

2. 部署静态文件到网站目录

3. 部署后端文件到应用目录

4. 自动安装依赖并重启服务



### 5. 服务管理

```bash
# 查看服务状态
pm2 status clawcloud

# 查看日志
pm2 logs clawcloud

# 重启服务
pm2 restart clawcloud
```




