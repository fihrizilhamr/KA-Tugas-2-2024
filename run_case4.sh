#!/bin/sh

docker rm -f mysql_case4 phpmyadmin_case4 myprocess_case4

docker container run \
    -dit \
    --name mysql_case4 \
    -v $(pwd)/dbdata:/var/lib/mysql \
    -e MYSQL_DATABASE=mydb_case4 \
    -e MYSQL_PASSWORD=mydb6789tyui \
    -e MYSQL_ROOT_PASSWORD=mydb6789tyui \
    -e MYSQL_ROOT_HOST=% \
    mysql:8.0-debian

sleep 10
docker exec -i mysql_case4 mysql -u root -pmydb6789tyui -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
docker exec -i mysql_case4 mysql -u root -pmydb6789tyui -e "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'mydb6789tyui';"
docker exec -i mysql_case4 mysql -u root -pmydb6789tyui mydb_case4 <<EOF
CREATE TABLE IF NOT EXISTS jokes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    joke_text TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
EOF


chmod -R 755 ./html
docker container run \
    -dit \
    --name phpmyadmin_case4 \
    -p 2222:80 \
    -v $(pwd)/html:/var/www/html/case4 \
    -e PMA_HOST=mysql_case4 \
    -e MYSQL_ROOT_PASSWORD=mydb6789tyui \
    --link mysql_case4:mysql1 \
    phpmyadmin:5.2.1-apache


docker exec -it phpmyadmin_case4 ls /var/www/html

chmod +x scripts/run_getjokes.sh
docker container run \
    -dit \
    --name myprocess_case4 \
    -v $(pwd)/scripts:/scripts \
    --link mysql_case4:mysql_case4 \
    alpine:3.18 \
    /bin/sh /scripts/run_getjokes.sh


