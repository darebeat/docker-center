# README

DNSPOD DNS Authenticator plugin for Certbot

## Prepare an API Token
Fetch an api token on [https://www.dnspod.cn/console/user/security](https://www.dnspod.cn/console/user/security)

## Install certbot and plugin

```sh
pip install certbot-dns-dnspod
```

## Create a credentials file

```sh
mkdir -p /opt/certbot
cat > /opt/certbot/dnspod.conf < EOF
certbot_dns_dnspod:dns_dnspod_email = "DNSPOD-API-REQUIRES-A-VALID-EMAIL"
certbot_dns_dnspod:dns_dnspod_api_token = "DNSPOD-API-TOKEN"
EOF
```

## Generate a certificate

```sh
certbot certonly -a certbot-dns-dnspod:dns-dnspod \
  --certbot-dns-dnspod:dns-dnspod-credentials /opt/certbot/dnspod.conf \
  -d *.darebeat.cn \
  -d darebeat.cn
```