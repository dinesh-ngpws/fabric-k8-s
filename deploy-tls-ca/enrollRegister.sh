#!/bin/sh

export FABRIC_CA_CLIENT_HOME=$PWD
set -x
fabric-ca-client enroll -d -u https://admin:adminpw@34.78.133.32:7054 --tls.certfiles ${PWD}/rootca/tls-ca-cert.pem 
fabric-ca-client register -d --id.name peer-org --id.secret peerpw --id.type peer -u https://34.78.133.32:7054 --tls.certfiles ${PWD}/rootca/tls-ca-cert.pem 
fabric-ca-client register -d --id.name admin-org --id.secret adminpw --id.type admin -u https://34.78.133.32:7054 --tls.certfiles ${PWD}/rootca/tls-ca-cert.pem 
fabric-ca-client register -d --id.name user-org --id.secret clientpw --id.type client -u https://34.78.133.32:7054 --tls.certfiles ${PWD}/rootca/tls-ca-cert.pem 
fabric-ca-client register -d --id.name orderer --id.secret ordererpw --id.type orderer -u https://34.78.133.32:7054 --tls.certfiles ${PWD}/rootca/tls-ca-cert.pem 
set +x