#!/bin/bash
# Following https://docs.docker.com/engine/security/https/
if [[ $# -eq 0 || $# -eq 1 && $1 -eq '-h' ]]; then
  echo "Usage: docker_gen_certs.sh hostname"
  exit 1
fi
export CNHOST=$1
echo "Generating certs for host $CNHOST"
echo "CA"
openssl genrsa -aes256 -out ca-key.pem 4096
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
chmod -v 0400 ca-key.pem
chmod -v 0444 ca.pem

echo "Server"
openssl genrsa -out server-key.pem 4096
openssl req -subj "/CN=$CNHOST" -sha256 -new -key server-key.pem -out server.csr
echo "subjectAltName = DNS:${CNHOST}" > extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf
rm -v server.csr extfile.cnf
chmod -v 0400 server-key.pem
chmod -v 0444 server-cert.pem

echo "Client"
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
echo "extendedKeyUsage = clientAuth" > extfile.cnf
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf
rm extfile.cnf
rm -v client.csr
chmod -v 0400 key.pem
chmod -v 0444 cert.pem
