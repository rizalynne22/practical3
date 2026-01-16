FROM httpd:alpine3.22
WORKDIR /app
ENTRYPOINT ["sleep", "6000000"]
RUN addgroup addgrp
RUN adduser -D -G appgrp app

RUN sed -i -e 's/User www-data/User app/' /usr/local/apache2/conf/httpd.conf
RUN sed -i -e 's/Group www-data/Group appgrp/' /usr/local/apache2/conf/httpd.conf
RUN sed -i -e 's/ServerAdmin you@example.com/ServerAdmin support@orbixia.ie/' /usr/local/apache2/conf/httpd.conf
