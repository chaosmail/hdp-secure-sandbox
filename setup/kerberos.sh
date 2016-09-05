echo '******* install kerberos'
yum -y install krb5-server krb5-libs krb5-auth-dialog krb5-workstation

echo '******* configure kerberos'
cat > /etc/krb5.conf <<EOF
[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 default_realm = HWX.COM
 dns_lookup_realm = false
 dns_lookup_kdc = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true

[realms]
 HWX.COM = {
  kdc = sandbox.hortonworks.com
  admin_server = sandbox.hortonworks.com
 }

[domain_realm]
 .sandbox.hortonworks.com = HWX.COM
 sandbox.hortonworks.com = HWX.COM
EOF

sed -i.bak s/EXAMPLE/HWX/g /var/kerberos/krb5kdc/kdc.conf
sed -i.bak s/EXAMPLE/HWX/g /var/kerberos/krb5kdc/kadm5.acl

echo '******* setup keytabs'
mkdir -p /etc/security/keytabs/
chown root:hadoop /etc/security/keytabs
chmod 750 /etc/security/keytabs