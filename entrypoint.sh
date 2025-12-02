#!/bin/bash

# GitHub 仓库地址
REPO_URL="https://github.com/yansd001/yansdhomepage.git"
WEB_DIR="/usr/share/nginx/html"
REPO_DIR="/repo"
# 同步间隔（秒），默认 300 秒（5分钟）
SYNC_INTERVAL=${SYNC_INTERVAL:-300}

# 初始化：克隆仓库
echo "Cloning repository..."
git clone "$REPO_URL" "$REPO_DIR"

# 复制文件到 nginx 目录
sync_files() {
    echo "$(date): Syncing files..."
    cd "$REPO_DIR"
    git pull origin main
    cp -r "$REPO_DIR"/* "$WEB_DIR/" 2>/dev/null || true
    # 排除不需要的文件
    rm -f "$WEB_DIR/Dockerfile" "$WEB_DIR/entrypoint.sh" "$WEB_DIR/README.md"
    rm -rf "$WEB_DIR/.git" "$WEB_DIR/.github"
    echo "$(date): Sync completed."
}

# 首次同步
sync_files

# 后台定时同步
(
    while true; do
        sleep "$SYNC_INTERVAL"
        sync_files
    done
) &

# 启动 nginx
echo "Starting nginx..."
nginx -g "daemon off;"
