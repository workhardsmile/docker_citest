# Set the base image to Ubuntu
FROM hub.c.163.com/library/ubuntu:14.04

# File Author / Maintainer
MAINTAINER  Frank Wu "gang.wu@istuary.com"

# share log file
RUN mkdir -p /var/www && chmod 0777 /var/www
WORKDIR /var/www
VOLUME ["/var/www"]

# Setup all needed dependencies
COPY ./sources.list /etc/apt/sources.list
RUN apt-get update &&\
    apt-get -y upgrade
RUN apt-get -y install \
	build-essential \
	bison openssl \
	libreadline6 \
	libreadline6-dev \
	curl \
	git-core \
	zlib1g \
	zlib1g-dev \
	libssl-dev \
	libyaml-dev  \
	libxml2-dev \
	libxslt-dev \
	autoconf \
	libc6-dev \
	zlib1g-dev \
	libssl-dev \
	libc6-dev \
	g++ \
	gcc \
	wget \
	libcurl4-openssl-dev \
	nodejs \
	libsqlite3-dev \
	sqlite3 \
	imagemagick \
	imagemagick-common \
	libmagickwand-dev \
	libmysqlclient-dev

# Install rvm and ruby
ENV RUBY_VERSION 1.9.3
#RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable
RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc
RUN /bin/bash -l -c 'rvm requirements' &&\
	/bin/bash -l -c 'rvm install $RUBY_VERSION && rvm use $RUBY_VERSION --default' &&\
 	/bin/bash -l -c 'rvm rubygems current'

# Install bundler and rails
ENV RAILS_VERSION 3.2.6
ENV BUNDLE_VERSION 1.12.5
RUN /bin/bash -l -c 'gem sources -a https://gems.ruby-china.org/' &&\
    #/bin/bash -l -c 'gem sources -a https://mirrors.aliyun.com/rubygems/' &&\
	/bin/bash -l -c 'gem sources -r https://rubygems.org/' &&\
	/bin/bash -l -c 'gem install bundler --version=$BUNDLE_VERSION' &&\
	/bin/bash -l -c 'gem install rails --version=$RAILS_VERSION'
	
# Install nginx and passenger
RUN /bin/bash -l -c 'gem install rack --version 1.4.7' &&\
    /bin/bash -l -c 'gem install passenger --version 5.1.2' &&\
    /bin/bash -l -c 'passenger-install-nginx-module --auto --auto-download'
#RUN wget -O /etc/init.d/nginx https://gist.github.com/hisea/1548664/raw/53f6d7ccb9dfc82a50c95e9f6e2e60dc59e4c2fb/nginx &&\
#	chmod +x /etc/init.d/nginx

COPY ./startup.sh /startup.sh
COPY ./Gemfile /root/Gemfile
RUN chmod +x /startup.sh &&\
	cd /root &&\
	/bin/bash -l -c 'echo $(bundle install)'
COPY ./nginx.conf.bak /opt/nginx/conf/nginx.conf

# Expose ports
EXPOSE 80 443 8001 8002 8003 8004 8005

# Set the default command to execute
# when creating a new container
CMD ["/startup.sh"]