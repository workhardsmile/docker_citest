FROM hub.c.163.com/workhardsmile/citestplus:passenger-nginx

# File Author / Maintainer
MAINTAINER  Frank Wu "gang.wu@istuary.com"

COPY ./startup.sh /startup.sh
RUN chmod +x /startup.sh &&\
	apt-get install -y python-pip &&\
    pip install supervisor	
COPY ./supervisor.conf /supervisor.conf

# Expose ports
EXPOSE 80 443 8001 8002 8003 8004 8005

# Set the default command to execute
# when creating a new container
CMD ["/startup.sh"]