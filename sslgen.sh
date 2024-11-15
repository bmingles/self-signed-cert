# Check that exactly 1 arg is provided
if [ "$#" -ne 1 ]; then
    echo "Missing required argument. Usage: $0 <domain>"
    exit 1
fi

pushd certs

domain=$1

openssl req -x509 -nodes \
 -subj "/CN=$domain" \
 -addext "subjectAltName = DNS:$domain" \
 -newkey rsa:1024 -keyout "$domain.key" -out "$domain.crt" -sha256 -days 3650

popd