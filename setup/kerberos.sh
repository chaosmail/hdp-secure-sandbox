while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -r|--realm)
    REALM=${2:-"HWX.COM"}
    shift # past argument
    ;;
    -d|--domain_realm)
    DOMAIN_REALM=${2:-"hortonworks.com"}
    shift # past argument
    ;;
    -k|--kdbmaster_key)
    KDBMASTER_KEY=${2:-"admin"}
    shift # past argument
    ;;
    -a|--adminprinc_pass)
    ADMINPRINC_PASS=${2:-"admin"}
    shift # past argument
    ;;
    -h|--kdc_host)
    KDC_HOST=${2:-"sandbox.hortonworks.com"}
    shift # past argument
    ;;
    -s|--admin_server)
    ADMIN_SERVER=${2:-"sandbox.hortonworks.com"}
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

echo '******* install kerberos'
yum -y install krb5-server krb5-libs krb5-auth-dialog krb5-workstation

echo '******* configure kerberos'
cat > /etc/krb5.conf <<EOF
[logging]
 default = FILE:/var/log/krb5libs.log
 kdc = FILE:/var/log/krb5kdc.log
 admin_server = FILE:/var/log/kadmind.log

[libdefaults]
 default_realm = ${REALM}
 dns_lookup_realm = false
 dns_lookup_kdc = false
 ticket_lifetime = 24h
 renew_lifetime = 7d
 forwardable = true

[realms]
 ${REALM} = {
  kdc = ${KDC_HOST}
  admin_server = ${ADMIN_SERVER}
 }

[domain_realm]
 .${DOMAIN_REALM} = ${REALM}
 ${DOMAIN_REALM} = ${REALM}
EOF

ESCAPED_REALM=`echo $REALM | sed 's/\./\\\\./g'`
sed -i.bak s/EXAMPLE\.COM/$ESCAPED_REALM/g /var/kerberos/krb5kdc/kdc.conf
sed -i.bak s/EXAMPLE\.COM/$ESCAPED_REALM/g /var/kerberos/krb5kdc/kadm5.acl

echo '******* setup keytabs'
mkdir -p /etc/security/keytabs/
chown root:hadoop /etc/security/keytabs
chmod 750 /etc/security/keytabs

echo '******* setup kerberos'
printf "$KDBMASTER_KEY\n$KDBMASTER_KEY\n" | kdb5_util create -s

echo '******* starting kadmin'
service kadmin start

echo '******* adding admin principal'
printf "$ADMINPRINC_PASS\n$ADMINPRINC_PASS\n" | kadmin.local -q "addprinc sandbox/admin"

echo '******* starting kdc'
service krb5kdc start