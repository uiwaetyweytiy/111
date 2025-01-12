#!/bin/bash

# 提示用户输入待解封&加速的域名
echo -n "请输入待解封&加速的域名（如www.abc.com）："
read domain

# 检查域名格式是否规范
function check_domain_format() {
  if [[ ! "$1" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    echo "域名格式不规范，请重新输入。"
    return 1
  fi
  return 0
}

while true; do
  if check_domain_format "$domain"; then
    break
  else
    echo -n "请重新输入待解封&加速的域名（如www.abc.com）："
    read domain
  fi
done

# 提示用户输入优选IP
echo -n "请输入优选IP（如1.1.1.1）："
read preferred_ip

# 检查IP格式是否规范
function check_ip_format() {
  if [[ ! "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "IP地址格式不规范，请重新输入。"
    return 1
  fi
  return 0
}

while true; do
  if check_ip_format "$preferred_ip"; then
    break
  else
    echo -n "请重新输入优选IP（如1.1.1.1）："
    read preferred_ip
  fi
done

# 删除/etc/hosts中包含该域名的行
sudo sed -i "/$domain/d" /etc/hosts

# 将优选IP和域名追加到/etc/hosts文件
echo "$preferred_ip    $domain" | sudo tee -a /etc/hosts > /dev/null

# 显示最后一行添加的内容
echo "操作已完成，已添加以下内容到/etc/hosts："
sudo tail -n 1 /etc/hosts
sleep 1
echo "如果要添加别的域名，可重新运行本脚本，5秒后自动退出..."
sleep 5
