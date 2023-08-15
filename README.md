# Self-signed cert

Generates self-signed cert for `localhost`

./sslgen.sh

Add server.crt as trusted cert

## Dev Settings

.env.development.local

```sh
HOST='0.0.0.0'
PORT=443
SSL_CERTS_DIR=/path/to/this/repo/certs/
```
