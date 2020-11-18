# README

## 准备DNSPORD API TOKEN
Fetch an api token on [https://www.dnspod.cn/console/user/security](https://www.dnspod.cn/console/user/security)

## 创建dnspod.conf配置文件

```sh
cat > dnspod.conf < EOF
certbot_dns_dnspod:dns_dnspod_email = "DNSPOD-API-REQUIRES-A-VALID-EMAIL"
certbot_dns_dnspod:dns_dnspod_api_token = "DNSPOD-API-TOKEN"
EOF
```

## 生成一个证书

```sh
docker run --rm -it \
-v `pwd`/dnspod.conf:/opt/certbot/dnspod.conf \
-v `pwd`/etc:/etc/letsencrypt \
-v `pwd`/lib:/var/lib/letsencrypt \
-v `pwd`/log:/var/log/letsencrypt \
darebeat/certbot \
certbot certonly -a certbot-dns-dnspod:dns-dnspod \
  --certbot-dns-dnspod:dns-dnspod-credentials /opt/certbot/dnspod.conf \
  -d *.darebeat.cn \
  -d darebeat.cn
```

## 自动续期

```sh
docker run --rm -it \
-v `pwd`/dnspod.conf:/opt/certbot/dnspod.conf \
-v `pwd`/etc:/etc/letsencrypt \
-v `pwd`/lib:/var/lib/letsencrypt \
-v `pwd`/log:/var/log/letsencrypt \
darebeat/certbot renew
```