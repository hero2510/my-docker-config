FROM nginx:latest

MAINTAINER tungvo (tung@starseed.fr)

RUN echo 'stream {' >> /etc/nginx/nginx.conf
RUN echo 'include /etc/nginx/stream.d/*.conf;' >> /etc/nginx/nginx.conf
RUN echo '}' >> /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
