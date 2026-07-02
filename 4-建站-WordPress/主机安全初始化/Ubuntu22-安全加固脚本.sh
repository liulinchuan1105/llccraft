#!/usr/bin/env bash
# ============================================================
# 阿里云国际 ECS · Ubuntu 22.04 LTS 安全加固大纲
# 适用：瓷器独立站 llccraft.com 美西-硅谷节点,首登后立即执行
# 原则：胆大心细,每步前 echo 提示,出问题 Ctrl+C 中断
# 生成日期：2026-07-01 | 执行人：Claude Code（远程下发,老板复制粘贴）
# ============================================================
set -euo pipefail

# ---------- 0. 预设值(老板替换这些占位符) ----------
NEW_USER="your_admin_user_placeholder"          # 非 root 操作账号(建议:llccraft_admin)
NEW_SSH_PORT="your_ssh_port_placeholder"        # 改 SSH 端口(建议:自定义 5 位数 ≠ 22)
BT_PANEL_PORT="your_bt_panel_port_placeholder"  # 宝塔面板端口(建议:自定义 5 位数 ≠ 8888)
ADMIN_IP_CIDR="your_admin_ip_cidr_placeholder"  # 你的家庭/办公出口 IP

echo "▶ 0. 预设值已就位"
echo "   新用户: $NEW_USER"
echo "   新 SSH 端口: $NEW_SSH_PORT"
echo "   宝塔端口: $BT_PANEL_PORT"
echo "   允许登录源 IP: $ADMIN_IP_CIDR"
echo

# ---------- 1. 系统更新 ----------
echo "▶ 1. 换源 + 更新"
sed -i 's|http://archive.ubuntu.com|https://mirrors.aliyun.com|g' /etc/apt/sources.list || true
apt update && apt upgrade -y
echo "✅ 系统已最新"
echo

# ---------- 2. 建非 root 用户 ----------
echo "▶ 2. 建非 root 操作用户: $NEW_USER"
if ! id "$NEW_USER" >/dev/null 2>&1; then
    adduser "$NEW_USER" --gecos "" --disabled-password
    echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/"$NEW_USER"
    chmod 440 /etc/sudoers.d/"$NEW_USER"
    echo "✅ 用户 $NEW_USER 已建,sudo NOPASSWD 已配"
else
    echo "⚠️ 用户 $NEW_USER 已存在,跳过"
fi
echo

# ---------- 3. 配 SSH 密钥(此处仅占位 —— 用法见下方"用法") ----------
echo "▶ 3. 配 SSH 公钥(老板把你的 id_ed25519.pub 内容粘进去)"
mkdir -p /home/"$NEW_USER"/.ssh
touch /home/"$NEW_USER"/.ssh/authorized_keys
chmod 700 /home/"$NEW_USER"/.ssh
chmod 600 /home/"$NEW_USER"/.ssh/authorized_keys
chown -R "$NEW_USER":"$NEW_USER" /home/"$NEW_USER"/.ssh
echo "👉 请把本地 id_ed25519.pub 内容粘贴到下面这一行后回车:"
echo "   (输入后回车,然后 Ctrl+D 结束)"
cat >> /home/"$NEW_USER"/.ssh/authorized_keys <<'EOF'
your_public_key_placeholder
EOF
echo "✅ 公钥已写入(ssh-ed25519 推荐;若本地不是 ed25519 请替换中间)"
echo

# ---------- 4. 改 SSH 配置(改端口 + 禁密码 + 禁 root) ----------
echo "▶ 4. 改 /etc/ssh/sshd_config"
SSHD_CONF=/etc/ssh/sshd_config
cp "$SSHD_CONF" "${SSHD_CONF}.bak.$(date +%Y%m%d)"
sed -i "s/^#\?Port .*/Port $NEW_SSH_PORT/" "$SSHD_CONF"
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin no/' "$SSHD_CONF"
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication no/' "$SSHD_CONF"
sed -i 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' "$SSHD_CONF"
echo "✅ SSH 已配:端口 $NEW_SSH_PORT / 禁密码登录 / 禁 root 直登"
echo

# ---------- 5. 防火墙 ufw ----------
echo "▶ 5. 配 ufw 防火墙(只开 SSH 自定义端口 + 80 + 443)"
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow from "$ADMIN_IP_CIDR" to any port "$NEW_SSH_PORT" proto tcp comment 'admin SSH'
ufw allow 80/tcp comment 'HTTP'
ufw allow 443/tcp comment 'HTTPS'
ufw --force enable
ufw status verbose
echo "✅ ufw 已启用"
echo

# ---------- 6. fail2ban ----------
echo "▶ 6. 装 fail2ban(防 SSH 暴力破解)"
apt install -y fail2ban
cat > /etc/fail2ban/jail.local <<EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5

[sshd]
enabled = true
port = $NEW_SSH_PORT
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 86400
EOF
systemctl enable fail2ban
systemctl restart fail2ban
fail2ban-client status sshd || true
echo "✅ fail2ban 已启,sshd jail 在守"
echo

# ---------- 7. (可选)装宝塔面板 ----------
echo "▶ 7. 装宝塔面板(可选 —— 你也可以纯命令行不用宝塔)"
wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh
bash install.sh ed8484bbe
echo "✅ 宝塔面板已装;装完后会给你面板 URL + 临时账号,记得改端口"
echo

# ---------- 8. (可选)装 Nginx + MySQL + PHP via 宝塔 ----------
echo "▶ 8. 在宝塔里点一键装 LNMP(Nginx + MySQL + PHP 8.2)"

echo
echo "============================================================"
echo "🎉 加固大纲执行完毕,接下来:"
echo "   1. 新开一个 SSH 终端测试: ssh -i ~/.ssh/id_ed25519 -p $NEW_SSH_PORT $NEW_USER@<公网IP>"
echo "   2. 确认能登入后,再回到旧终端关掉旧 SSH 进程"
echo "   3. 安全组规则同步放开 $NEW_SSH_PORT(只对 $ADMIN_IP_CIDR 开)"
echo "============================================================"
