# Check that exactly 1 arg is provided
if [ "$#" -ne 1 ]; then
    echo "Missing required argument. Usage: $0 <CN>"
    exit 1
fi

pushd certs

cn=$1

# Generate a root CA certificate
openssl req \
 -x509 \
 -nodes \
 -subj "/C=US/O=Me/OU=Dev/CN=$cn" \
 -newkey rsa:4096 -keyout "rootCA.key" -out "rootCA.crt" -sha256 -days 3650

popd