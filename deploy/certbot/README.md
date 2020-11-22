# README

#### 配置文件准备

根据需要配置初始化配置,`token`建议写入配置文件

```sh
# dnspod.conf
cat > dnspod.conf << EOF
# dnspod
# [申请文档](https://www.dnspod.cn/console/user/security)
certbot_dns_dnspod:dns_dnspod_email = "DNSPOD-API-REQUIRES-A-VALID-EMAIL"
certbot_dns_dnspod:dns_dnspod_api_token = "DNSPOD-API-TOKEN"
EOF

# .env
cat > .env << EOF
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

#### 生成一个证书

```sh
cat > docker-compose.yaml << EOF
version: "3"

services:
  certbot:
    image: darebeat/certbot
    container_name: certbot
    env_file:
      - .env
    environment: 
      - CERT_START_MODE=certonly # 控制初始化或自动续期
      - CERT_DNS_VENDOR=hwy # dnspod|hwy|txy|aly|godaddy
      - CERT_EMAIL=darebeat@126.com
      - CERT_REQ_DOMAINS=darebeat.cn,*.darebeat.cn,*.blog.darebeat.cn # 多个域名用英文逗号隔开
      - CERT_CRON_TIME=1 1 */7 * * # crontab日期格式 # 分 时 日 月 周
      - CERT_LOG_DIR=/var/log
      - TZ=Asia/Shanghai
    volumes:
      - ./etc:/etc/letsencrypt:z
      - ./lib:/var/lib/letsencrypt:z
      - ./log:/var/log/letsencrypt:z
      - ./domains:/opt/certbot/certbot-dns-cnyun/domains:ro
      # - ./docker-entrypoint.sh:/docker-entrypoint.sh # 可以根据需要调整脚本
    entrypoint: /docker-entrypoint.sh # 覆盖镜像默认指令
    command: 
      - certonly    # 同CERT_START_MODE,可以任选其一进行配置(这个优先级高)
      - hwy         # 同CERT_DNS_VENDOR,可以任选其一进行配置(这个优先级高)
EOF

# 启动并查看日志
docker-compose up
```

#### 自动续期

```sh
cat > docker-compose.yaml << EOF
version: "3"

services:
  certbot:
    image: darebeat/certbot
    container_name: certbot
    env_file:
      - .env
    environment: 
      - CERT_START_MODE=renew-auto # 控制初始化或自动续期
      - CERT_DNS_VENDOR=hwy # dnspod|hwy|txy|aly|godaddy
      - CERT_EMAIL=darebeat@126.com
      - CERT_REQ_DOMAINS=darebeat.cn,*.darebeat.cn,*.blog.darebeat.cn # 多个域名用英文逗号隔开
      - CERT_CRON_TIME=1 1 */7 * * # crontab日期格式,证书有效期<30天才会renew，所以crontab可以配置为1天或1周 # 分 时 日 月 周
      - CERT_LOG_DIR=/var/log
      - TZ=Asia/Shanghai
    volumes:
      - ./etc:/etc/letsencrypt:z
      - ./lib:/var/lib/letsencrypt:z
      - ./log:/var/log/letsencrypt:z
      - ./domains:/opt/certbot/certbot-dns-cnyun/domains:ro
      # - ./docker-entrypoint.sh:/docker-entrypoint.sh # 可以根据需要调整脚本
    entrypoint: /docker-entrypoint.sh # 覆盖镜像默认指令
    command: 
      - renew-auto  # 同CERT_START_MODE,可以任选其一进行配置(这个优先级高)
      - hwy         # 同CERT_DNS_VENDOR,可以任选其一进行配置(这个优先级高)
EOF

# 启动
docker-compose up -d
# 查看日志
docker logs -f certbot
docker exec -it certbot tail -f ${CERT_LOG_DIR:-/var/log}/renew.log
```
#### 环境变量说明

+ `CERT_START_MODE`: 控制初始化或自动续期 `<必选项>`
  - `certonly`   第一次初始化证书
  - `renew`      手动控制证书更新
  - `renew-auto` 自动控制初始化和自动续期
  - `*`          其他情况,参考最原始命令
+ `CERT_DNS_VENDOR` 域名解析提供的供应商,和域名云服务器对应;
  - `dnspod`|`hwy`|`txy`|`aly`|`godaddy` 调用不同的dns解析生成验证证书
  - `*` 其他情况,参考最原始命令
+ `CERT_EMAIL`: 域名过期通知邮箱 `<必选项>`
+ `CERT_REQ_DOMAINS`: 需要生成证书的域名,多个域名用英文逗号分隔;生成的证书文件夹名称以第一个作为标准 `<必选项>`
+ `CERT_CRON_TIME`: 定时自动证书续期;当且仅当`CERT_START_MODE=renew-auto`时使用,默认`1 1 */1 * *` `<可选项>`
+ `CERT_LOG_DIR`: 设置自动证书续期日志目录;当且仅当`CERT_START_MODE=renew-auto`时使用,默认`/var/log` `<可选项>`

#### 调整启动脚本

+ 取消docker-compose.yaml中的注释
  - 调整前: `# - ./docker-entrypoint.sh:/docker-entrypoint.sh # 可以根据需要调整脚本`;
  - 调整后: `- ./docker-entrypoint.sh:/docker-entrypoint.sh # 可以根据需要调整脚本`;

+ 在本地编写和调整`./docker-entrypoint.sh`

#### 问题与支持

+ **Blog  :** [https://blog.darebeat.cn/tag/letsencrypt/](https://blog.darebeat.cn/tag/letsencrypt/)
+ **Github:** [https://github.com/darebeat/docker-center/tree/master/deploy/certbot](https://github.com/darebeat/docker-center/tree/master/deploy/certbot)
+ **Gitee :** [https://gitee.com/darebeat/docker-center.git](https://gitee.com/darebeat/docker-center.git)
