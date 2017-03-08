# URL to the Ambari Repo
AMBARI_REPO_URL=${1:-"http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.0.1/ambari.repo"}

# Add the Ambari Repo
# https://docs.hortonworks.com/HDPDocuments/Ambari/Ambari-2.4.0.1/index.html#bk_ambari-installation
echo '******* download ambari repo'
wget -nv $AMBARI_REPO_URL -O /etc/yum.repos.d/ambari.repo

# Install Ambari client
echo '******* setup ambari-agent'
yum install -y ambari-agent

# Start the agent
echo '******* start ambari-agent'
service ambari-agent start