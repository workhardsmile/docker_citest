FROM hub.c.163.com/workhardsmile/citestplus:passenger-nginx

# File Author / Maintainer
MAINTAINER  Frank Wu "gang.wu@istuary.com"

COPY ./startup.sh /startup.sh
RUN echo "0 1 * * * root /bin/sh /var/nginx/conf/crontab.sh >> /dev/null 2>&1">/etc/crontab &&\
    chmod +x /startup.sh &&\
    mkdir -p /var/nginx/conf &&\
    mkdir -p /var/nginx/log &&\
    apt-get -y install python-pip &&\
    pip install supervisor

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./nginx-sites.conf /var/nginx/conf/nginx-sites.conf
COPY ./supervisor.conf /var/nginx/conf/supervisor.conf
COPY ./crontab.sh /var/nginx/conf/crontab.sh
VOLUME ["/var/nginx/conf","/var/nginx/log", "/var/www"]

# Expose ports
EXPOSE 80 443 8001 8002 8003 8004 8005

# Set the default command to execute
# when creating a new container
CMD ["/startup.sh"]