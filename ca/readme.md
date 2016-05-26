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
-subj "/C=UA/ST=OD/L=Odessa/O=DarkPark Ltd/CN=DarkPark ECC Certification Authority/emailAddress=darkpark.main@gmail.com"
```

Create RSA certificate:

```bash
openssl req -x509 -new -key root.rsa.key -days 10000 -out root.rsa.crt \
-subj "/C=UA/ST=OD/L=Odessa/O=DarkPark Ltd/CN=DarkPark ECC Certification Authority/emailAddress=darkpark.main@gmail.com"
```