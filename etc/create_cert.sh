# Create CA
mkdir -p cert
certtool --generate-privkey > cert/cakey.pem
cat > cert/ca.info <<EOF
cn = libvirt.local
ca
cert_signing_key
EOF
certtool --generate-self-signed --load-privkey cert/cakey.pem \
  --template cert/ca.info --outfile cert/cacert.pem


# Create Server Cert
certtool --generate-privkey > cert/serverkey.pem
cat > cert/server.info <<EOF
organization = Libvirt Server
cn = libvirt.local
tls_www_server
encryption_key
signing_key
EOF
certtool --generate-certificate \
         --template cert/server.info \
         --load-privkey cert/serverkey.pem \
         --load-ca-certificate cert/cacert.pem \
         --load-ca-privkey cert/cakey.pem \
         --outfile cert/servercert.pem


# Create Client Cert
certtool --generate-privkey > cert/clientkey.pem
cat > cert/client.info <<EOF
organization = Cuckoo Client
cn = cuckoo.local
tls_www_client
encryption_key
signing_key
EOF
certtool --generate-certificate \
         --template cert/client.info \
         --load-privkey cert/clientkey.pem \
         --load-ca-certificate cert/cacert.pem \
         --load-ca-privkey cert/cakey.pem \
         --outfile cert/clientcert.pem


# Copy certificates
mkdir -p /etc/pki/libvirt/private
mkdir -p /etc/pki/CA
cp cert/cacert.pem /etc/pki/CA/
cp cert/servercert.pem /etc/pki/libvirt/
cp cert/serverkey.pem /etc/pki/libvirt/private
chown -R root:libvirt /etc/pki/libvirt
chmod 755 /etc/pki/libvirt
chmod 750 /etc/pki/libvirt/private
chmod 440 /etc/pki/libvirt/private/*

# Make client folder
mkdir -p cert/client
cp cert/cacert.pem cert/clientcert.pem cert/clientkey.pem cert/client

