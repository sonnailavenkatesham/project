
FROM nginx:alpine

RUN apk add --no-cache curl unzip

RUN rm -rf /usr/share/nginx/html/*

ADD web /usr/share/nginx/html/

COPY roboshop.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
