docker info
docker version
docker images
docker search ubuntu
docker pull ubuntu
docker run ubuntu echo hello docker
docker run -p 8080:80 -d nginx
docker ps
docker cp index.html 5d03ad3c3b46://usr/share/nginx/html
docker stop 5d03ad3c3b46
docker commit -m 'fun' 09c37f5a2672 nginx-fun
docker rmi 266614bc718d
docker ps -a
docker rm 09c37f5a2672 5d03ad3c3b46 9c31aaabf7e6

--Dockerfile
FROM alpine:latest
MAINTAINER steven-pc\steven
CMD echo "Hello Docker!"

docker build -t hello_docker .

--Dockerfile
FROM ubuntu
MAINTAINER steven-pc\steven
RUN apt-get update
RUN apt-get install -y nginx
COPY index.html /var/www/html
ENTRYPOINT ["usr/sbin/nginx", "-g", "daemon off;"]
EXPOSE 80

docker run -d -name nginx -v /usr/share/nginx/html nginx
docker inspect nginx
docker exec -it nginx /bin/bash
docker run -p 80:80 -d -v $PWD/html:/usr/share/nginx/html nginx

docker create -v $PWD/data:/var/mydata --name data_container ubuntu
docker run -it --volumes-from data_container ubuntu /bin/bash
docker tag docker/whalesay steven/whalesay
docker push steven/whalesay
docker login

docker-compose up -d
docker-compose stop
docker-compose rm
docker-compose build

docker run --name mysql -v C:\Users\Steven\Desktop\docker\mysql\data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=VTPhz8Gj --net=host -p 3306:3306 -d mysql:5.7.15
docker exec -it mysql mysql
