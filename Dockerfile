FROM daocloud.io/nginx

COPY dist/ /sell-app-front
COPY server/ /sell-app-server
COPY nginx/sellapp.conf /etc/nginx/conf.d/sellapp.conf

RUN \
    echo "deb http://mirrors.163.com/debian/ jessie main non-free contrib\ndeb http://mirrors.163.com/debian/ jessie-updates main non-free contrib\ndeb http://mirrors.163.com/debian/ jessie-backports main non-free contrib\ndeb-src http://mirrors.163.com/debian/ jessie main non-free contrib\ndeb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib\ndeb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib\ndeb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib\ndeb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib" | tee /etc/apt/sources.list  && \
    apt-get update && \
    apt-get install -y python-pip && \
    pip install -r /sell-app-server/requirement.txt -i https://pypi.douban.com/simple &&\
    chmod 777 -R /sell-app-*

CMD sh -c 'nginx && python /sell-app-server/server.py'
