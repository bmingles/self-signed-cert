pushd certs

openssl req -x509 -nodes \
 -subj '/CN=localhost' \
 -addext "subjectAltName = DNS:localhost" \
 -newkey rsa:1024 -keyout server.key -out server.crt -sha256 -days 3650

popd