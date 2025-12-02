FROM nginx:alpine

# 安装 git 和相关工具
RUN apk add --no-cache git bash

# 删除默认的 nginx 配置
RUN rm -rf /usr/share/nginx/html/*

# 复制启动脚本
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 暴露端口
EXPOSE 80

# 使用启动脚本
CMD ["/entrypoint.sh"]
