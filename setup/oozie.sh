echo '******* setup oozie user and db'
mysql -h localhost -u root -e "CREATE DATABASE IF NOT EXISTS oozie;"
mysql -h localhost -u root -e "CREATE USER 'oozie'@'localhost' IDENTIFIED BY 'oozie';"
mysql -h localhost -u root -e "GRANT ALL PRIVILEGES ON oozie.* TO 'oozie'@'localhost';"