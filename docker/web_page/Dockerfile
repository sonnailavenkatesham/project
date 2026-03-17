FROM nginx:1.25

# remove default content
RUN rm -rf /usr/share/nginx/html/*
RUN rm -f /etc/nginx/conf.d/default.conf

# copy config
COPY roboshop.conf /etc/nginx/conf.d/default.conf

# copy frontend
COPY --chown=nginx:nginx web /usr/share/nginx/html/

# validate config
RUN nginx -t

EXPOSE 80