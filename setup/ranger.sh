echo '******* setup ranger user and db'
mysql -h localhost -u root -e "CREATE DATABASE IF NOT EXISTS ranger;"
mysql -h localhost -u root -e "CREATE USER 'rangeradmin'@'localhost' IDENTIFIED BY 'rangeradmin';"
mysql -h localhost -u root -e "GRANT ALL PRIVILEGES ON ranger.* TO 'rangeradmin'@'localhost';"