FROM httpd:alpine3.22
WORKDIR /app
ENTRYPOINT ["sleep", "6000000"]
