## README

A docker commom images build and deploy.


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