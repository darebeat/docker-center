## README

A docker commom images build and deploy.


#### env install

```sh
curl -sSL https://get.daocloud.io/docker | sh
curl -L "https://github.com/docker/compose/releases/download/1.17.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

#### build

Some docker images example for build.


#### deploy

Some docker instance deploy daily.


#### change the local mirror for fast pull speed

```sh
cat << eof > /etc/docker/daemon.json
{
  "registry-mirrors": [
    "https://ya4ouoma.mirror.aliyuncs.com"
  ]
}
eof
```