FROM node:20-alpine as Builder
RUN apk update && apk add --no-cache git
WORKDIR /src
RUN git clone https://github.com/mdn/todo-react
WORKDIR /src/todo-react
RUN npm install --no-audit --no-fund
RUN npm run build

FROM httpd:alpine3.22 
RUN addgroup appgrp
RUN adduser -D -G appgrp app
RUN sed -i 's/User www-data/User app/' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's/Group www-data/Group appgrp/' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's/ServerAdmin you@example.com/ServerAdmin support@orbixia.ie/' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's/Listen 80/Listen 8080/' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's/:80/:8080/' /usr/local/apache2/conf/httpd.conf
RUN chown -R app:appgrp /usr/local/apache2
RUN apk update && apk add --no-cache --upgrade "libxml2=2.13.9-r0"
COPY --from=Builder /src/todo-react/dist /usr/local/apache2/htdocs/
USER app:appgrp
