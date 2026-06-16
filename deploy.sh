#!/bin/bash
# 一键部署脚本 - PM 面试指南
# 用法: bash deploy.sh

set -e

PROJECT_DIR="/home/voley/projects/pm-interview-site"
REPO_NAME="pm-interview"
REPO_URL="https://github.com/Voley-Gong/${REPO_NAME}"

cd "$PROJECT_DIR"

echo "=== 检查 gh 认证状态 ==="
if ! gh auth status &>/dev/null; then
    echo "❌ 未认证！请先运行: gh auth login"
    exit 1
fi
echo "✅ 已认证"

echo ""
echo "=== 创建 GitHub 仓库 ==="
if gh repo view "$REPO_NAME" &>/dev/null 2>&1; then
    echo "⚠️  仓库已存在，跳过创建"
else
    gh repo create "$REPO_NAME" --public --description "产品经理面试题库 - 产品思维/需求管理/用户研究/数据指标/技术转PM"
    echo "✅ 仓库已创建: $REPO_URL"
fi

echo ""
echo "=== Git 初始化并推送 ==="
if [ ! -d .git ]; then
    git init
    git branch -M main
fi

if git remote get-url origin &>/dev/null; then
    git remote set-url origin "$REPO_URL"
else
    git remote add origin "$REPO_URL"
fi

git add -A
git commit -m "🚀 PM面试指南初始化 - 7分类 7篇种子题目"

git push -u origin main

echo ""
echo "=== 部署完成！ ==="
echo "GitHub Actions 正在构建部署..."
echo "仓库地址: $REPO_URL"
echo ""
echo "⚠️  重要：请到 GitHub 仓库 Settings → Pages → Source 选择 'GitHub Actions'"
echo "部署完成后访问: https://voley-gong.github.io/pm-interview/"
