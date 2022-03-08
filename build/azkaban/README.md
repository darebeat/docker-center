1: Build the image executor

    docker build --rm -t darebeat/azkaban-executor .

2: Build the image webserver

    docker build --rm -t darebeat/azkaban-webserver .

3: Start containers

    docker-compose up -d

4: Copy and initialize database (azkaban-db-3.57.0.tar.gz / create-all-sql.sql)

    docker cp create-all-sql.sql mysql:/
    mysql -uroot -ptest azkaban < create-all-sql.sql

5: Access the web UI :
[https://127.0.0.1:8443](https://127.0.0.1:8443)  
username: azkaban  
password: azkaban

6: Create project for test

    #command.job
    type=command
    command=echo 'hello azkaban'