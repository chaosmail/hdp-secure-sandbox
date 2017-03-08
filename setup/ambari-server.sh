# URL to the Ambari Repo
AMBARI_REPO_URL=${1:-"http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.0.1/ambari.repo"}

# Add the Ambari Repo
# https://docs.hortonworks.com/HDPDocuments/Ambari/Ambari-2.4.0.1/index.html#bk_ambari-installation
echo '******* download ambari repo'
wget -nv $AMBARI_REPO_URL -O /etc/yum.repos.d/ambari.repo

# Install MySQL
echo '******* install and configure MySQL'
yum install -y mariadb mariadb-server

# Start MySQL
systemctl start mariadb
mysql_upgrade -u root

# Install Ambari Server
echo '******* install ambari-server'
yum install -y ambari-server

# Install DB connectors
echo '******* install db connectors'
yum install -y postgresql-jdbc mysql-connector-java

# Setup Ambari Server
echo '******* setup ambari-server' 
ambari-server setup --silent \
  -j /usr/lib/jvm/jre-openjdk/

# Configure Ambari Server for MySQL
ambari-server setup --silent \
  --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql-connector-java.jar

echo '******* start ambari-server' 
service ambari-server start

# Generate a new SSH Key
echo '******* setup ssh' 
ssh-keygen -q -N "" -f ~/.ssh/id_rsa
touch ~/.ssh/authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
