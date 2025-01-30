# Check that exactly 1 arg is provided
if [ "$#" -ne 1 ]; then
    echo "Missing required argument. Usage: $0 <domain>"
    exit 1
fi

pushd certs

domain=$1

ca_key="rootCA.key"
ca_crt="rootCA.crt"
server_key="$domain.key"
server_crt="$domain.crt"
server_csr="$domain.csr"
ext="$domain.ext"

cat <<EOF > $ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
subjectAltName = @alt_names
[alt_names]
DNS.1 = $domain
EOF

# This generates a private key and a CSR. The private key is used to generate
# the CSR but is also the private key that will be paired with the signed cert
# created in the next step.
echo 'Generating CSR...'
openssl req \
 --nodes \
 -newkey rsa:2048 \
 -subj "/C=US/ST=Tennessee/L=Spring Hill/O=Acme/OU=Dev/CN=$domain" \
 -keyout "$server_key" \
 -out "$server_csr"

# Generate a certificate signed by the root CA using the CSR generated above.
echo 'Sign our cert with CA...'
openssl x509 -req \
 -days 365 \
 -CA "$ca_crt" \
 -CAkey "$ca_key" \
 -in "$server_csr" \
 -out "$server_crt" \
 -CAcreateserial \
 -extfile "$ext"