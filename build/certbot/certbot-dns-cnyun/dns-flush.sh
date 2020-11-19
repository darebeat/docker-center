#!/bin/sh

CURR_DIR=$(cd `dirname $0`; pwd)

#填写阿里云的AccessKey ID及AccessKey Secret
#如何申请见https://help.aliyun.com/knowledge_detail/38738.html
ALY_KEY=${ALY_KEY:-""}
ALY_TOKEN=${ALY_TOKEN:-""}

#填写腾讯云的SecretId及SecretKey
#如何申请见https://console.cloud.tencent.com/cam/capi
TXY_KEY=${TXY_KEY:-""}
TXY_TOKEN=${TXY_TOKEN:-""}

#填写华为云的 Access Key Id 及 Secret Access Key
#如何申请见https://support.huaweicloud.com/devg-apisign/api-sign-provide.html
HWY_KEY=${HWY_KEY:-""}
HWY_TOKEN=${HWY_TOKEN:-""}

#GoDaddy的SecretId及SecretKey
#如何申请见https://developer.godaddy.com/getstarted
GODADDY_KEY=${GODADDY_KEY:-""}
GODADDY_TOKEN=${GODADDY_TOKEN:-""}

# 命令行参数
# 第1个参数：使用那个 DNS 的 API
# 第2个参数：add or clean
pdns=$1 #aly, txy, hwy, godaddy
paction=$2 #add or clean

# 内部变量
key=""
token=""

if [[ "$paction" != "clean" ]]; then
  paction="add"
fi

if [[ "$pdns" == "aly" ]]; then
  dnsapi=$CURR_DIR/plugins/alydns.py
  key=$ALY_KEY
  token=$ALY_TOKEN
elif [[ "$pdns" == "txy" ]] ;then
  dnsapi=$CURR_DIR/plugins/txydns.py
  key=$TXY_KEY
  token=$TXY_TOKEN
elif [[ "$pdns" == "txy" ]]; then
  dnsapi=$CURR_DIR/plugins/txydns.py
  key=$TXY_KEY
  token=$TXY_TOKEN
elif [[ "$pdns" == "hwy" ]]; then
  dnsapi="$CURR_DIR/plugins/hwydns.py"
  key=$HWY_KEY
  token=$HWY_TOKEN
elif [[ "$pdns" == "godaddy" ]] ;then
  dnsapi=$CURR_DIR/plugins/godaddydns.py
  key=$GODADDY_KEY
  token=$GODADDY_TOKEN
else 
  echo "Not support this dns services"
  exit
fi

# python plugins/hwydns.py add "darebeat.cn" "_acme-challenge" "7kdPSpwWXD2" $HWY_KEY $HWY_TOKEN
python $dnsapi $paction $CERTBOT_DOMAIN "_acme-challenge" $CERTBOT_VALIDATION $key $token >>"/var/log/certd.log"

if [[ "$paction" == "add" ]]; then
  # DNS TXT 记录刷新时间
  /bin/sleep 20
fi

