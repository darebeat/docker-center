#! /bin/sh

CERT_START_MODE=${1:-$CERT_START_MODE};shift;
CERT_DNS_VENDOR=${1:-$CERT_DNS_VENDOR};shift;
CERT_START_MODE=${CERT_START_MODE:-certonly}
CERT_DNS_VENDOR=${CERT_DNS_VENDOR:-hwy}
CERT_CRON_TIME=${CERT_CRON_TIME:-"1 1 1 * *"}
CERT_EMAIL=${CERT_EMAIL:-darebeat@126.com}
CERT_REQ_DOMAINS=${CERT_REQ_DOMAINS:-"*.darebeat.cn"}
CERT_REQ_DOMAIN=$(echo ${CERT_REQ_DOMAINS}|awk -F '[ ,]' '{print $1}')
CERT_REQ_DOMAIN=${CERT_REQ_DOMAIN/\*./}

_CCH="/opt/certbot/certbot-dns-cnyun/dns-flush.sh ${CERT_DNS_VENDOR}"
_LOG_DIR="${CERT_LOG_DIR:-/var/log}"
CERT_PEM_LIVE_PATH=/etc/letsencrypt/live
CERT_PEM_DOMAIN_PATH=${CERT_PEM_LIVE_PATH}/${CERT_REQ_DOMAIN}

echo "------------------------------------------------"
echo "CERT_START_MODE  : ${CERT_START_MODE}"
echo "CERT_REQ_DOMAINS : ${CERT_REQ_DOMAINS}"
echo "CERT_REQ_DOMAIN  : ${CERT_REQ_DOMAIN}"
echo "CERT_EMAIL       : ${CERT_EMAIL}"
echo "CERT_DNS_VENDOR  : ${CERT_DNS_VENDOR}"
echo "\$@              : $@"
echo
echo "_LOG_DIR             : ${_LOG_DIR}"
echo "CERT_PEM_LIVE_PATH   : ${CERT_PEM_LIVE_PATH}"
echo "CERT_PEM_DOMAIN_PATH : ${CERT_PEM_DOMAIN_PATH}"
echo "------------------------------------------------"

_get_pem_wc(){
  # 获取证书目录的文件(软链接)个数,默认生成4个
  [ -d ${CERT_PEM_LIVE_PATH} -a -d ${CERT_PEM_DOMAIN_PATH} ] && _fc=`ls -l ${CERT_PEM_DOMAIN_PATH}|grep "^l"|wc -l|cut -f8 -d ' '`
  echo ${_fc:-0}
}

_renew_auto(){
  # 初始化生成证书,并生成crontab定时任务定时对证书自动续期
  case $CERT_DNS_VENDOR in
    hwy|aly|txy|godaddy)
      (
        # crontab -l;
        echo "${CERT_CRON_TIME} certbot renew $@ --manual --preferred-challenges dns --manual-auth-hook \"${_CCH} add\" --manual-cleanup-hook \"${_CCH} clean\">>${_LOG_DIR}/renew.log"
      ) | uniq > /etc/crontabs/certbot 
      ;;
    dp|dnspod)
      ( 
        # crontab -l;
        echo "${CERT_CRON_TIME} certbot renew $@ >> ${_LOG_DIR}/renew.log"
      ) | uniq > /etc/crontabs/certbot
      ;;
    *)
      (
        # crontab -l;
        echo "${CERT_CRON_TIME} certbot renew $@ >> ${_LOG_DIR}/renew.log"
      ) | uniq > /etc/crontabs/certbot
      ;;
  esac
  crontab /etc/crontabs/certbot
  pkill crond
  crond
}

_renew(){
  # 一次性调用进行证书自动续期
  case $CERT_DNS_VENDOR in
    hwy|aly|txy|godaddy)
      certbot renew \
        --manual --preferred-challenges dns \
        --manual-auth-hook \"${_CCH} add\" \
        --manual-cleanup-hook \"${_CCH} clean\" $@
      ;;
    dp|dnspod)
      certbot renew $@
      ;;
    *)
      certbot renew $@
      ;;
  esac
}

_certonly(){
  # 初始化生成证书
  rm -rf ${CERT_PEM_DOMAIN_PATH} # 替换域名目录 

  case $CERT_DNS_VENDOR in 
    hwy|aly|txy|godaddy)
      certbot certonly \
        -n --agree-tos \
        -m ${CERT_EMAIL} \
        -d ${CERT_REQ_DOMAINS} \
        --manual-public-ip-logging-ok \
        --manual --preferred-challenges dns \
        --manual-auth-hook "${_CCH} add" \
        --manual-cleanup-hook "${_CCH} clean" $@
      ;;
    dp|dnspod)
      certbot certonly \
        -n --agree-tos \
        -m ${CERT_EMAIL} \
        -d ${CERT_REQ_DOMAINS} \
        --manual-public-ip-logging-ok \
        -a dns-dnspod \
        --preferred-challenges dns \
        --certbot-dns-dnspod:dns-dnspod-credentials /opt/certbot/dnspod.conf \
        --server https://acme-v02.api.letsencrypt.org/directory $@
      ;;
    *)
      certbot certonly $@  
      ;;
  esac
}

if [ ${CERT_START_MODE}x == "renew-auto"x ]; then
  _n=0;
  _fc=$(_get_pem_wc)
  while [ $_fc -ne 4 -a $_n -le 3 ]; do
    [ $_n -gt 0 ] && echo "==> Warning: certbot certonly retry ${_n} times running."
    # 如果没有生成对应的live文件,重新生成
    $(_certonly $@ >> ${_LOG_DIR}/renew-auto.log)
    [ $_n -gt 0 ] && echo "==> Warning: certbot certonly retry ${_n} times ended."
    _n=$((_n + 1));
    _fc=$(_get_pem_wc)
    [ ! $_fc -eq 4 ] && sleep 60;
  done
  unset _n _fc

  $(_renew_auto $@)
  echo "==> Warning: Due to network reasons, you should check whether the certificate is generated correctly. If it is failed, we will retry 3 times every 1 minute by default."
  echo "==> Warning: You can find more information in ${_LOG_DIR}/renew-auto.log"
  echo "==> Log: `date +"%Y-%m-%d %H:%M:%S"` ==> certbot renew-auto is started."
  # 日志监控,常驻进程,防止容器退出
  touch ${_LOG_DIR}/renew-auto.log && tail -f ${_LOG_DIR}/renew-auto.log
elif [ ${CERT_START_MODE}x == "renew"x ]; then
  echo "==> Log: `date +"%Y-%m-%d %H:%M:%S"` ==> running: certbot renew."
  $(_renew $@)
  echo "==> Log: `date +"%Y-%m-%d %H:%M:%S"` ==> ended: certbot renew."
elif [ ${CERT_START_MODE}x == "certonly"x ]; then
  echo "==> Log: `date +"%Y-%m-%d %H:%M:%S"` ==> running: certbot certonly."
  $(_certonly $@)
  echo "==> Log: `date +"%Y-%m-%d %H:%M:%S"` ==> ended: certbot certonly." 
else
  echo "==> Log: `date +"%Y-%m-%d %H:%M:%S"` ==> running: certbot source command."
  certbot $@;
  echo "==> Log: `date +"%Y-%m-%d %H:%M:%S"` ==> ended: certbot source command."
fi