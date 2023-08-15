pushd certs

# Generate private key
openssl genrsa -aes256 -passout pass:$PWD -out server.pass.key 4096
openssl rsa -passin pass:$PWD -in server.pass.key -out server.key
rm server.pass.key

# Create CSR
openssl req -new -key server.key -out server.csr

# Create cert
openssl x509 -req -sha256 -extfile ../v3.ext -days 365 -in server.csr -signkey server.key -out server.crt

popd