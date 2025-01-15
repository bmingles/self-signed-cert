# Check that exactly 1 arg is provided
if [ "$#" -ne 1 ]; then
    echo "Missing required argument. Usage: $0 <domain>"
    exit 1
fi

pushd certs

domain=$1

ca_key="$domain.CA.key"
ca_crt="$domain.CA.crt"
server_key="$domain.key"
server_crt="$domain.crt"
server_csr="$domain.csr"
ext="$domain.ext"

# https://www.baeldung.com/openssl-self-signed-cert

echo 'Generating private key and CSR...'
openssl req \
 --nodes \
 -newkey rsa:2048 \
 -subj "/C=US/ST=Tennessee/L=Spring Hill/O=Acme/OU=Dev/CN=$domain" \
 -keyout "$server_key" \
 -out "$server_csr"

echo 'Generating CA...'
openssl req \
 -x509 \
 -sha256 \
 --nodes \
 -days 1825 \
 -newkey rsa:2048 \
 -subj "/C=US/ST=Tennessee/L=Spring Hill/O=Acme/OU=Dev/CN=$domain" \
 -keyout "$ca_key" \
 -out "$ca_crt"

echo 'Sign our cert with CA...'
openssl x509 -req \
 -days 365 \
 -CA "$ca_crt" \
 -CAkey "$ca_key" \
 -in "$server_csr" \
 -out "$server_crt" \
 -CAcreateserial \
 -extfile "$ext"
