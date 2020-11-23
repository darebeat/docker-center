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
```

## 生成`dhparams`

```sh
openssl dhparam -out .conf/certs/dhparams.pem 2048
```