# Self-signed cert

Generates self-signed cert for `localhost`

## Generating Certs

1. Run script with desired domain name (e.g. localhost, local.deephaven.io, somefakelocal.com)

```sh
./sslgen.sh localhost
```

2. Add the generated `.crt` as trusted cert

## Dev Settings

> Note: DHE expects certs to be named `server.crt` and `server.key`

.env.development.local

```sh
HOST='0.0.0.0'
PORT=443
SSL_CERTS_DIR=/path/to/this/repo/certs/
```
