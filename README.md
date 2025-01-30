# Self-signed cert

Generates self-signed cert for `localhost`

## Generating Certs

Run script with desired domain name (e.g. localhost, local.deephaven.io, somefakelocal.com)

```sh
./sslgen.sh localhost
```

or to generate and sign with a CA cert

1. (one time only) generate a root CA `./gen-ca.sh`
1. Generate cert signed by CA `./gen-signed-crt.sh`

## Trusting Cets

1. Add the generated server `.crt` as trusted cert to your OS cert store, or if you generated and signed with a CA cert, add the CA cert.

1. For nodejs clients, you will need to set `NODE_EXTRA_CA_CERTS` to the path of the signing cert. Multiple can be included by concatenating them together in the file.
