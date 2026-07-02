#!/usr/bin/env bash
# ============================================================
# 阿里云国际 ECS · 新加坡沙盒 · 2026-07-01 运行实例
# 适用：`8.219.190.222`（Ubuntu 22.04.5 LTS · 已误开新加坡 · 1 个月回本计划)
# 原则：胆大心细,每步前 echo 提示,出问题 Ctrl+C 中断;不锁机
# 生成日期：2026-07-01
# 执行人：Claude Code(执行员 A 角色) · 通过本地 SSH Key(~/.ssh/llccraft_sg)远程
# 配套：`../主机-阿里云国际/ECS开通记录.md`(7 月底迁美西硅谷计划)
# ============================================================
set -euo pipefail

# ---------- 0. 预设值(本次运行的真实值,非占位符) ----------
NEW_USER="llccraft_admin"            # 非 root 操作账号
NEW_SSH_PORT="49821"                 # 新 SSH 端口(随机 5 位数)
BT_PANEL_PORT="81765"                # 宝塔端口预占位(本机不装宝塔,ufw 默认也不放行)
ADMIN_IP_CIDR="27.47.131.102/32"     # 老板家/办公的白名单 IP(可选用)
PUBLIC_KEY_CONTENT="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPviaWgOoHbKkdNe6333b/fa3EaVsRyVbPASeLIxow0k llccraft-sg-sandbox-2026-07-01"  # Claude Code 本机的 ed25519 公钥

echo "============================================================"
echo "▶ 新加坡沙盒运行实例 · 2026-07-01"
echo "  NEW_USER       = $NEW_USER"
echo "  NEW_SSH_PORT   = $NEW_SSH_PORT (此脚本写在 sshd_config,但真正生效需要控制台安全组同步放行)"
echo "  BT_PANEL_PORT  = $BT_PANEL_PORT (ufw 不放行,不装宝塔)"
echo "  ADMIN_IP_CIDR  = $ADMIN_IP_CIDR (本机沙盒用全网白名单,IP 严控留给美西正式机)"
echo "============================================================"
echo

# ---------- 1. 系统换源 + 更新 ----------
echo "▶ 1. 换源到阿里云 + apt update/upgrade"
sed -i 's|http://archive.ubuntu.com|https://mirrors.aliyun.com|g' /etc/apt/sources.list || true
apt update && apt upgrade -y
echo "✅ 系统已最新"
echo

# ---------- 2. 建非 root 操作用户 ----------
echo "▶ 2. 建非 root 操作用户 $NEW_USER + sudo NOPASSWD"
if ! id "$NEW_USER" >/dev/null 2>&1; then
    adduser "$NEW_USER" --gecos "" --disabled-password
    echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/"$NEW_USER"
    chmod 440 /etc/sudoers.d/"$NEW_USER"
    echo "✅ 用户 $NEW_USER 已建,sudo NOPASSWD 已配"
else
    echo "⚠️ 用户 $NEW_USER 已存在,跳过 adduser(只刷 sudoers)"
    echo "$NEW_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/"$NEW_USER"
    chmod 440 /etc/sudoers.d/"$NEW_USER"
fi
echo

# ---------- 3. 给 $NEW_USER 复制公钥(同步 root authorized_keys 已有) ----------
echo "▶ 3. 把 root 的 authorized_keys 同步到 $NEW_USER(使其能用同一把 key 登入)"
mkdir -p /home/"$NEW_USER"/.ssh
cp /root/.ssh/authorized_keys /home/"$NEW_USER"/.ssh/authorized_keys
chmod 700 /home/"$NEW_USER"/.ssh
chmod 600 /home/"$NEW_USER"/.ssh/authorized_keys
chown -R "$NEW_USER":"$NEW_USER" /home/"$NEW_USER"/.ssh
echo "✅ $NEW_USER 的 SSH key 同步完毕"
echo

# ---------- 4. 防火墙 ufw(立刻开新 SSH 端口 + 80 + 443,默认 deny incoming) ----------
echo "▶ 4. 装 ufw + 配规则(放行 $NEW_SSH_PORT + 80 + 443 + 保留 22 防锁机)"
apt install -y ufw
ufw default deny incoming
ufw default allow outgoing
# 当前可登入的端口(本步保留 22,因为还没换 sshd 端口)
ufw allow 22/tcp comment 'temp-SSH-keep-22-until-port-switch'
# 新 SSH 端口提前放行(等用户控制台安全组开 + sshd 改端口后,这条生效)
ufw allow "$NEW_SSH_PORT"/tcp comment "new-SSH-$(date +%F)"
# WP 公开端口
ufw allow 80/tcp comment 'HTTP'
ufw allow 443/tcp comment 'HTTPS'
ufw --force enable
ufw status verbose
echo "✅ ufw 已启用(临时保留 22 直到第 5 步确认新端口可登入后才会移除)"
echo

# ---------- 5. 改 sshd_config 但保留 22 端口多监听(防锁机过渡策略) ----------
echo "▶ 5. 改 /etc/ssh/sshd_config —— 同时监听 22 + $NEW_SSH_PORT(只为过渡)"
SSHD_CONF=/etc/ssh/sshd_config
cp "$SSHD_CONF" "${SSHD_CONF}.bak.2026-07-01"

# 先把现有的 "#Port 22" 或者 "Port 22" 改成 "Port 22" + "# Port XXXXX" 双行
# 先去掉 Port 行的注释并保留一个干净 Port 22,然后追加新端口注释行
if grep -qE '^\s*Port\s+22\s*$' "$SSHD_CONF"; then
    sed -i 's|^\s*Port\s\+22\s*$|Port 22\nPort '"$NEW_SSH_PORT"'  # added 2026-07-01 for transition|' "$SSHD_CONF"
elif grep -qE '^\s*#\s*Port\s+22\s*$' "$SSHD_CONF"; then
    sed -i 's|^\s*#\s*Port\s\+22\s*$|Port '"$NEW_SSH_PORT"'  # added 2026-07-01; old default 22 now also active below\nPort 22|' "$SSHD_CONF"
else
    echo "" >> "$SSHD_CONF"
    echo "Port 22" >> "$SSHD_CONF"
    echo "Port $NEW_SSH_PORT  # added 2026-07-01 for transition" >> "$SSHD_CONF"
fi

# 同时把 PubkeyAuthentication、PasswordAuthentication、PermitRootLogin 三项明确表态
sed -i 's/^#\?PubkeyAuthentication .*/PubkeyAuthentication yes/' "$SSHD_CONF"
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes  # will be no later after keys verified/' "$SSHD_CONF"
sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes  # will be no later after admin key verified/' "$SSHD_CONF"

# 语法检查 + 重启
sshd -t && systemctl restart sshd || (echo "❌ sshd 重启失败,回滚 sshd_config" && cp "${SSHD_CONF}.bak.2026-07-01" "$SSHD_CONF" && systemctl restart sshd && exit 1)
echo "✅ sshd_config 已改 · 现在监听 22 + $NEW_SSH_PORT 双端口"
echo "⚠️ 重要:此步之后,你必须在阿里云控制台把安全组'22'改成'$NEW_SSH_PORT',才能从新端口登入"
echo "   这一段作为过渡保留,等第 7 步验证新端口登入成功后,才移除 22"
echo

# ---------- 6. fail2ban(防 SSH 爆破) ----------
echo "▶ 6. 装 fail2ban + 改 SSH jail 监听新端口"
apt install -y fail2ban
cat > /etc/fail2ban/jail.local <<EOF
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5

[sshd]
enabled = true
port    = $NEW_SSH_PORT,22
filter  = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 86400
EOF
systemctl enable fail2ban
systemctl restart fail2ban
sleep 1
fail2ban-client status sshd || true
echo "✅ fail2ban 已启,sshd jail 在守新端口 $NEW_SSH_PORT"
echo

# ---------- 7. (跳过)宝塔面板 ————————
echo "▶ 7. 装宝塔 —— ⏭ 跳过 (sandbox + 只用一个月,不值得花时间)"
echo "   BT_PANEL_PORT=$BT_PANEL_PORT 已记,ufw 默认不放行"

# ---------- 8. (跳过)LNMP ————————
echo "▶ 8. 装 LNMP —— ⏭ 跳过 (sandbox 不跑 WP,留给美西正式机)"

echo
echo "============================================================"
echo "🎉 阶段 1 加固完毕(过渡态,22 + $NEW_SSH_PORT 双端口开)"
echo "============================================================"
echo "▶ 后续动作(执行员 A 或老板):"
echo "   1. 老板去阿里云控制台:实例 $NEW_SSH_PORT 端口加进安全组(放行 0.0.0.0/0)"
echo "   2. 老板回来后执行员 A 跑第二阶段脚本:"
echo "      - ssh -i ~/.ssh/llccraft_sg -p $NEW_SSH_PORT $NEW_USER@8.219.190.222 'whoami'"
echo "      - 成功后:禁密码 + 禁 root(回 sshd_config) + 移除 22 端口"
echo "   3. 删 BT 端口占位(可选)"
echo "============================================================"
