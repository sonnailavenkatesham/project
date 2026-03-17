FROM nginx

# remove default static content
RUN rm -rf /usr/share/nginx/html/*

# remove default nginx site config (optional but fine)
RUN rm -f /etc/nginx/conf.d/default.conf

# add your nginx server config (THIS is the right place)
COPY roboshop.conf /etc/nginx/conf.d/default.conf

# add frontend files
COPY web /usr/share/nginx/html/