##说明

####1. 导入docker镜像

```
docker load < ./images/data.tar
docker load < ./images/mysql.tar
docker load < ./images/php.tar
docker load < ./images/redis.tar
docker load < ./images/jenkins.tar
docker load < ./images/mongo.tar
docker load < ./images/passenger-nginx.tar
```

####2. 初始化

```
mkdir -p ../data/nginx/conf
mkdir -p ../data/nginx/www
mkdir -p ../data/mysql
cp -fr ./config/* ../data/nginx/conf/
tar -zxf ./web-app/test-plus.tar.gz -C ../data/nginx/www
tar -zxf ./web-app/testlink.tar.gz -C ../data/nginx/www
tar -zxf ./web-app/testplus-logserver.tar.gz -C ../data/nginx/www
tar -zxf ./web-app/update-testlink.tar.gz -C ../data/nginx/www
tar -zxf ./web-app/all_db.tar.gz -C ../data/mysql
docker-compose up -d
docker exec -it passenger-nginx bash
cd /var/www/test-plus
bundle install
cd /var/www/testplus-logserver
bundle install
cd /var/www/update-testlink
bundle install
exit
docker exec -it mysql sh
cd /data/mysql
mysql -u root -e 'source all_db.sql.txt;'
exit
docker-compose stop 
docker-compose up -d
```
####3. 停止

```
docker-compose stop
```
####4. 域名

> 参见../data/nginx/conf/nginx-sites.conf
127.0.0.1   www.testplus.com
127.0.0.1   www.logserver.com
127.0.0.1   www.update-testlink.com
127.0.0.1   www.testlink.com
127.0.0.1   www.jenkins.com