$ kdb5_util create -s
Loading random data
Initializing database '/var/kerberos/krb5kdc/principal' for realm 'HWX.COM',
master key name 'K/M@HWX.COM'
You will be prompted for the database Master Password.
It is important that you NOT FORGET this password.
Enter KDC database master key: `admin`
Re-enter KDC database master key to verify: `admin`

$ service kadmin start
$ kadmin.local -q "addprinc sandbox/admin"
Authenticating as principal root/admin@HWX.COM with password.
WARNING: no policy specified for sandbox/admin@HWX.COM; defaulting to no policy
Enter password for principal "sandbox/admin@HWX.COM": 
Re-enter password for principal "sandbox/admin@HWX.COM": 
Principal "admin/sandbox@HWX.COM" created.

$ service krb5kdc start

$ kadmin.local -q "addprinc -randkey hivetest@HWX.COM"
$ kadmin.local -q "ktadd -k /etc/security/keytabs/hivetest.keytab -norandkey hivetest@HWX.COM"
$ chown hivetest /etc/security/keytabs/hivetest.keytab
$ chmod 700 /etc/security/keytabs/hivetest.keytab