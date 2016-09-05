# Secure HDP 2.4 Sandbox

Centos 7 Vagrant Box with Ambari 2.4.0.1 and Kerberos

## Pre-requisites
- Minimum 8 GB of RAM for the HDP 2.4.2 Sandbox

## Steps
1. Download and install Vagrant for your host OS: https://www.vagrantup.com/downloads.html
  * Install [vagrant-hostsupdater plugin](https://github.com/cogitatio/vagrant-hostsupdater)
  * Install [vagrant-vbguest plugin](https://github.com/dotless-de/vagrant-vbguest)
2. Download and install VirtualBox for your host OS: https://www.virtualbox.org/wiki/Downloads
3. Download and install git client for your host
4. Open a command shell and change to the folder where you plan to clone the github repository
5. Clone the Github repository:  `git clone https://github.com/chaosmail/hdp-secure-sandbox.git`
6. Change directory to `hdp-secure-sandbox`
7. Run `vagrant up`
8. Navigate to `http://sandbox.hortonworks.com:8080/` and setup your cluster
9. Run `vagrant ssh` and execute `kerberos_manual.sh` steps
10. Setup Kerberos via Amabari

## Configure the Cluster

1. Get started
  * Clustername: `Sandbox`
2. Select Version
  * Choose `HDP 2.4`
3. Install Options
  * Host: `sandbox.hortonworks.com`
  * Register manually
4. Choose your stack

### Ambari Configs

Ambari GUI

* User: `admin`
* Password: `admin`
* Clustername: `Sandbox`

Kerberos

* Master Principal: `root/admin@HWX.COM`
* Master Password: `admin`
* Sandbox Principal: `sandbox/admin@HWX.COM`
* Sandbox Password: `admin`
* Realm: `HWX.COM`

Knox

* Gateway Host: `sandbox.hortonworks.com`
* Knox Master Secret: `knoxadmin`

Ranger

* User: `admin`
* Password: `admin`
* MySQL User: `rangeradmin`
* MySQL Password: `rangeradmin`

Oozie

* MySQL User: `oozie`
* MySQL Password: `oozie`

MySQL

* Host: `localhost`
* User: `root`
* no password

## Resources

* https://github.com/timveil/hdp-vagrant-base
* https://docs.hortonworks.com/HDPDocuments/Ambari-2.4.0.1/bk_ambari-installation/content/log_in_to_apache_ambari.html
* https://ambari.apache.org/1.2.5/installing-hadoop-using-ambari/content/ambari-kerb-1-2.html
* https://github.com/crazyadmins/useful-scripts/tree/master/ambari
* http://henning.kropponline.de/2014/10/05/kerberized-hadoop-cluster-sandbox-example/
