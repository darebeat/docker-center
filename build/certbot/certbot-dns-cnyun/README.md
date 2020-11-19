[Fork From](https://github.com/ywdblog/certbot-letencrypt-wildcardcertificates-alydns-au.git)

### 功能

使用 certbot 工具，为不能自动给 letencrypt 通配符证书自动续期（renew）而烦恼吗？这个工具能够帮忙！

不管是申请还是续期，只要是通配符证书，只能采用 dns-01 的方式校验申请者的域名，也就是说 certbot 操作者必须手动添加 DNS TXT 记录。

如果你编写一个 Cron (比如 1 1 */1 * * root certbot-auto renew)，自动 renew 通配符证书，此时 Cron 无法自动添加 TXT 记录，这样 renew 操作就会失败，如何解决？

certbot 提供了一个 hook，可以编写一个 Shell 脚本，让脚本调用 DNS 服务商的 API 接口，动态添加 TXT 记录，这样就无需人工干预了。

在 certbot 官方提供的插件和 hook 例子中，都没有针对国内 DNS 服务器的样例，所以我编写了这样一个工具，目前支持**阿里云 DNS**、**腾讯云 DNS**、**华为云 NDS**、**GoDaddy**（certbot 官方没有对应的插件）。

1：配置

（1）domains

如果domains文件没有你的根域名，请自行添加。

（2）DNS API 密钥：

这个 API 密钥什么意思呢？由于需要通过 API 操作阿里云 DNS, 腾讯云 DNS 的记录，所以需要去域名服务商哪儿获取 API 密钥，然后配置在 au.sh 文件中:

- ALY_KEY 和 ALY_TOKEN：阿里云 [API key 和 Secrec 官方申请文档](https://help.aliyun.com/knowledge_detail/38738.html)。
- TXY_KEY 和 TXY_TOKEN：腾讯云 [API 密钥官方申请文档](https://console.cloud.tencent.com/cam/capi)。
- HWY_KEY 和 HWY_TOKEN: 华为云 [API 密钥官方申请文档](https://support.huaweicloud.com/devg-apisign/api-sign-provide.html)
- GODADDY_KEY 和 GODADDY_TOKEN：GoDaddy [API 密钥官方申请文档](https://developer.godaddy.com/getstarted)。

（3）选择运行环境参数

目前该工具支持五种运行环境和场景，通过 hook 文件和参数来调用：

- Python(支持2.7和3.7，无需任何第三方库)
  - dns-flush.sh aly add/clean：Python操作阿里云DNS，增加/清空DNS。
  - dns-flush.sh txy add/clean：Python操作腾讯云DNS，增加/清空DNS。
  - dns-flush.sh hwy add/clean：Python操作华为云DNS，增加/清空DNS。
  - dns-flush.sh godaddy add/clean：Python操作GoDaddy DNS，增加/清空DNS。

根据自己服务器环境和域名服务商选择任意一个 hook shell（包含相应参数），具体使用见下面。

2：下载安装certbot-auto

```sh
mkdir -p /opt/certbot
cd /opt/certbot
wget https://dl.eff.org/certbot-auto
chmod a+x certbot-auto
ln -s /opt/certbot/certbot-auto /usr/bin/certbot-auto
```

3：申请证书

测试是否有错误：

```sh
certbot-auto certonly  \
  -d *.example.com \
  --manual --preferred-challenges dns \
  --dry-run  \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly clean"
```

**Debug：** 操作 DNS API 可能会遇到一系列问题，比如 API token 权限不足，遇到相关问题，可以查看 /var/log/certd.log。

**重要解释：** --manual-auth-hook 和 --manual-cleanup-hook 有2个参数：

- 第1个参数代表你的DNS厂商(aly/txy)
- 第2个参数是固定的(--manual-auth-hook中用add，--manual-clean-hook中用clean)

比如你要选择Python环境，可以将 

```sh
--manual-auth-hook 输入修改为 "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly add"
--manual-cleanup-hook 输入修改为  "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly clean"
```

确认无误后，实际运行（去除 --dry-run 参数）：

```sh
# 实际申请
certbot-auto certonly  \
  -d *.example.com \
  --manual --preferred-challenges dns \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly clean"
```

参数解释（可以不用关心）：

- certonly：表示采用验证模式，只会获取证书，不会为web服务器配置证书
- --manual：表示插件
- --preferred-challenges dns：表示采用DNS验证申请者合法性（是不是域名的管理者）
- --dry-run：在实际申请/更新证书前进行测试，强烈推荐
- -d：表示需要为那个域名申请证书，可以有多个。
- --manual-auth-hook：在执行命令的时候调用一个 hook 文件
- --manual-cleanup-hook：清除 DNS 添加的记录

如果你想为多个域名申请通配符证书（合并在一张证书中，也叫做 **SAN 通配符证书**），直接输入多个 -d 参数即可，比如：

```sh
certbot-auto certonly \
  -d *.example.com \
  -d *.example.org \
  -d www.example.cn \
  --manual --preferred-challenges dns  \
  --dry-run \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly clean"
```

### 续期证书

1：对机器上所有证书 renew

```sh
certbot-auto renew  \
  --manual --preferred-challenges dns \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly clean"
```

2：对某一张证书进行续期

先看看机器上有多少证书：

```
certbot-auto certificates
```

可以看到很多证书，如图：

![管理证书](https://notes.newyingyong.cn/static/image/2018/2018-07-17-certbot-managercert.png)

记住证书名，比如 simplehttps.com，然后运行下列命令 renew：

```sh
certbot-auto renew \
  --cert-name simplehttps.com  \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly clean"
```

### 加入 crontab

```sh
# 新增renew.sh脚本
cat > /opt/certbot/renew.sh < EOF
certbot-auto renew \
  --manual --preferred-challenges dns \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly clean"
EOF
```

编辑文件 /etc/crontab :

```
# 证书有效期<30天才会renew，所以crontab可以配置为1天或1周
1 1 */1 * * root sh +x /opt/certbot/renew.sh
```

如果是certbot 机器和运行web服务（比如 nginx，apache）的机器是同一台，那么成功renew证书后，可以启动对应的web 服务器，运行下列crontab :

```sh
# 新增renew-nginx.sh脚本
cat > /opt/certbot/renew-nginx.sh < EOF
certbot-auto renew \
  --manual --preferred-challenges dns \
  --deploy-hook  "service nginx restart" \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh aly clean"
EOF
```

```
# 注意只有成功renew证书，才会重新启动nginx
1 1 */1 * * root sh +x /opt/certbot/renew-nginx.sh
```


**注意：只有单机建议这样运行，如果要将证书同步到多台web服务器，需要有别的方案，目前在开发中，主要目的就是同步证书到集群服务器上**

### 贡献

- 阿里云 python 版 @Duke-Wu
- 腾讯云 python 版 @akgnah
- 华为云 python 版 @jinhucheung
- GoDaddy PHP 版 wlx_1990 （2019-01-11）