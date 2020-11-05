# nginx配置


```sh
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