## nginx配置

```sh
cat > /etc/hosts << EOF
192.168.0.213 app-deploy-server

# 开放10104端口并重启防火墙：这个步骤不弄的话访问不到
firewall-cmd --add-port=10104/tcp --permanent
firewall-cmd --reload

firewall-cmd --remove-port=10104/tcp --permanent
firewall-cmd --reload
# 重启防火墙
systemctl restart firewalld.service
# 查看开放的端口
firewall-cmd --list-all


systemctl start firewalld  # 开启防火墙
systemctl stop firewalld   # 关闭防火墙
systemctl status firewalld # 查看防火墙开启状态，显示running则是正在运行
firewall-cmd --reload      # 重启防火墙，永久打开端口需要reload一下
```

## 生成`dhparams`

```sh
openssl dhparam -out ./conf/conf.d/dhparams.pem 2048
```