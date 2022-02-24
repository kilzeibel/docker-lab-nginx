FROM debian:bullseye-slim
USER root
RUN echo "deb http://ftp.ru.debian.org/debian/ bullseye main non-free" > /etc/apt/sources.list.d/ftp.ru.debian.org.list && \
apt update && apt upgrade -y && apt install nginx -y && apt clean && \
rm -rf /var/www/* && mkdir -p /var/www/company.com/img/
COPY ./index.html /var/www/company.com/
RUN useradd tim && groupadd shipilov && \
chmod -R 754 /var/www/company.com/ && \
chown -R tim:shipilov /var/www/company.com/ && \
sed -i 's/var\/www\/html/\/var\/www\/company.com/g' /etc/nginx/sites-enabled/default &&\
sed -i 's/user www-data;/user  tim;/g' /etc/nginx/nginx.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]