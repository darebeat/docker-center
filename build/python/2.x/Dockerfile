FROM centos:7.6.1810
MAINTAINER darebeat<darebeat@126.com>
ARG PYTHON_VERSION=2.7.18

RUN set -ex \
    # 预安装所需组件
    && yum install -y wget tar libffi-devel zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make initscripts zip\
    && wget --no-check-certificate https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz \
    && tar -zxvf Python-$PYTHON_VERSION.tgz \
    && cd Python-$PYTHON_VERSION \
    && ./configure prefix=/usr/local/python2 \
    && make \
    && make install \
    && make clean \
    && rm -rf /Python-$PYTHON_VERSION*
# 设置默认为python
RUN set -ex \
    && mv /usr/bin/python /usr/bin/python27 \
    && ln -s /usr/local/python2/bin/python /usr/bin/python
RUN set -ex \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py
RUN set -ex \
    && rm -rf /usr/bin/pip \
    && ln -s /usr/local/python2/bin/pip /usr/bin/pip
# 修复因修改python版本导致yum失效问题
RUN set -ex \
    && sed -i "s#/usr/bin/python#/usr/bin/python27#" /usr/bin/yum \
    && sed -i "s#/usr/bin/python#/usr/bin/python27#" /usr/libexec/urlgrabber-ext-down \
    && yum install -y deltarpm
# 更新pip版本
RUN pip install --upgrade pip
