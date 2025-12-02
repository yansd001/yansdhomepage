FROM nginx:alpine

# 删除默认的 nginx 配置
RUN rm -rf /usr/share/nginx/html/*

# 复制静态文件
COPY index.html /usr/share/nginx/html/

# 暴露端口
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
