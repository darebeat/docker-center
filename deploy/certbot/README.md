# README

## 配置文件准备

```sh
# dnspod.conf
cat > dnspod.conf < EOF
# dnspod
# [申请文档](https://www.dnspod.cn/console/user/security)
certbot_dns_dnspod:dns_dnspod_email = "DNSPOD-API-REQUIRES-A-VALID-EMAIL"
certbot_dns_dnspod:dns_dnspod_api_token = "DNSPOD-API-TOKEN"
EOF

# .env
cat > .env < EOF
# 阿里云
# [申请文档](https://help.aliyun.com/knowledge_detail/38738.html)
ALY_KEY=
ALY_TOKEN=
# 腾讯云
# [申请文档](https://console.cloud.tencent.com/cam/capi)
TXY_KEY=
TXY_TOKEN=
# 华为云
# [申请文档](https://support.huaweicloud.com/devg-apisign/api-sign-provide.html)
HWY_KEY=
HWY_TOKEN=
# GoDaddy
# [申请文档](https://developer.godaddy.com/getstarted)
GODADDY_KEY=
GODADDY_TOKEN=
EOF
```

## 生成一个证书

```sh
# dnspod
docker run --rm -it \
-v `pwd`/etc:/etc/letsencrypt \
-v `pwd`/lib:/var/lib/letsencrypt \
-v `pwd`/log:/var/log/letsencrypt \
-v `pwd`/dnspod.conf:/opt/certbot/dnspod.conf \
darebeat/certbot \
  certonly -a dns-dnspod \
  --certbot-dns-dnspod:dns-dnspod-credentials /opt/certbot/dnspod.conf \
  --preferred-challenges dns --server https://acme-v02.api.letsencrypt.org/directory \
  -m darebeat@126.com \
  -d *.darebeat.cn \
  -d darebeat.cn

# hwy/aly/txy/godaddy
docker run --rm -it \
-v `pwd`/etc:/etc/letsencrypt \
-v `pwd`/lib:/var/lib/letsencrypt \
-v `pwd`/log:/var/log/letsencrypt \
-v `pwd`/domains:/opt/certbot/certbot-dns-cnyun/domains \  # 根据需要进行扩展
--env-file `pwd`/.env \  # api key/token config
darebeat/certbot certonly \
  -m darebeat@126.com \
  -d *.darebeat.cn \
  -d *.blog.darebeat.cn \
  -d darebeat.cn \
  --manual --preferred-challenges dns \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh hwy add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh hwy clean"
```

## 自动续期

+ renew.sh

```sh
# dnspod
docker run --rm -it \
-v `pwd`/dnspod.conf:/opt/certbot/dnspod.conf \  # dnspod配置文件
-v `pwd`/etc:/etc/letsencrypt \
-v `pwd`/lib:/var/lib/letsencrypt \
-v `pwd`/log:/var/log/letsencrypt \
darebeat/certbot renew

# hwy/aly/txy/godaddy
docker run --rm -it \
-v `pwd`/etc:/etc/letsencrypt \
-v `pwd`/lib:/var/lib/letsencrypt \
-v `pwd`/log:/var/log/letsencrypt \
-v `pwd`/domains:/opt/certbot/certbot-dns-cnyun/domains \  # 根据需要进行扩展
--env-file `pwd`/.env \  # api key/token config
darebeat/certbot renew
  --manual --preferred-challenges dns \
  --manual-auth-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh hwy add" \
  --manual-cleanup-hook "/opt/certbot/certbot-dns-cnyun/dns-flush.sh hwy clean"
```
+ crontab

```sh
# 证书有效期<30天才会renew，所以crontab可以配置为1天或1周
1 1 */1 * * root sh +x `pwd`/renew.sh
```
