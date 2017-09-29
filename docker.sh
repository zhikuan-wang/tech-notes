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
