FROM python:3.10
#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
RUN rm -rf /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata
RUN DEBIAN_FRONTEND=noninteractive apt-get install git wget vim openssh-server -y
COPY start.sh /root/init/
WORKDIR /root/init
RUN sed -i "s/PermitRootLogin prohibit-password/#PermitRootLogin prohibit-password/g" /etc/ssh/sshd_config && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
COPY requirements.txt ./
#RUN python3 -m pip config set global.index-url https://mirrors.aliyun.com/pypi/simple && python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt
CMD ["bash", "./start.sh"]
