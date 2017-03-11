Certification Authority
=======================

Generate private key with explicit elliptic curve parameters:

```bash
openssl ecparam -genkey -name sect571r1 -param_enc explicit -out root.ecc.key
```

Generate private RSA key:

```bash
openssl genrsa -out root.rsa.key 4096
```

Create ECC certificate:

```bash
openssl req -x509 -new -key root.ecc.key -days 10000 -out root.ecc.crt \
-subj "/C=UA/ST=OD/L=Odessa/O=DarkPark Ltd/OU=DarkPark Home/CN=DarkPark ECC Certification Authority/emailAddress=darkpark.main@gmail.com"
```

Create RSA certificate:

```bash
openssl req -x509 -new -key root.rsa.key -days 10000 -out root.rsa.crt \
-subj "/C=UA/ST=OD/L=Odessa/O=DarkPark Ltd/OU=DarkPark Home/CN=DarkPark RSA Certification Authority/emailAddress=darkpark.main@gmail.com"
```

Add certificates to NSS database:

```bash
# add
certutil -d sql:$HOME/.pki/nssdb -A -t "CT,C,C" -n "DarkPark ECC Certification Authority - DarkPark Ltd" -i root.ecc.crt
certutil -d sql:$HOME/.pki/nssdb -A -t "CT,C,C" -n "DarkPark RSA Certification Authority - DarkPark Ltd" -i root.rsa.crt
# check
certutil -d sql:$HOME/.pki/nssdb -L
```

=== Creation a certificate signed with CA ===

Key generation:

```bash
openssl genrsa -out somedomain.key 4096
```

Certificate request (`Common Name` should be somedomain):

```bash
openssl req -new -key somedomain.key -out somedomain.csr -subj "/C=UA/ST=OD/L=Odessa/O=DarkPark Ltd/OU=NAS/CN=somedomain/emailAddress=darkpark.main@gmail.com"
```

Signing:

```bash
openssl x509 -req -in somedomain.csr -CA root.ecc.crt -CAkey root.ecc.key -CAcreateserial -out somedomain.crt -days 5000
```
