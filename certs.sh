#!/bin/bash

if [ ! -d certs ]; then
	mkdir -p certs/admin/tls-ca/
	mkdir -p certs/peerorg/
	mkdir -p certs/ordererorg/
	mkdir -p certs/peerorg/admin
	mkdir -p certs/peerorg/peer
	mkdir -p certs/peerorg/client
	mkdir -p certs/ordererorg/orderer
fi

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-tls-ca/rootca/tls-ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$PWD/certs/admin/tls-ca/
set -x
fabric-ca-client enroll -d -u https://admin:adminpw@34.78.133.32:7054 
fabric-ca-client register -d --id.name peer-org --id.secret peerpw --id.type peer -u https://34.78.133.32:7054 
fabric-ca-client register -d --id.name admin-org --id.secret adminpw --id.type admin -u https://34.78.133.32:7054 
fabric-ca-client register -d --id.name user-org --id.secret clientpw --id.type client -u https://34.78.133.32:7054 
fabric-ca-client register -d --id.name orderer --id.secret ordererpw --id.type orderer -u https://34.78.133.32:7054 
set +x

echo '#tls 
NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/34-78-133-32-7054.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/34-78-133-32-7054.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/34-78-133-32-7054.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/34-78-133-32-7054.pem
    OrganizationalUnitIdentifier: orderer'> $FABRIC_CA_CLIENT_HOME/msp/config.yaml

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-org-ca/rootca/org-ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$PWD/certs/peerorg/
set -x
fabric-ca-client enroll -d -u https://admin:adminpw@35.233.46.15:7054
fabric-ca-client register -d --id.name peer-org --id.secret peerpw --id.type peer -u https://35.233.46.15:7054
fabric-ca-client register -d --id.name admin-org --id.secret adminpw --id.type admin -u https://35.233.46.15:7054
fabric-ca-client register -d --id.name user-org --id.secret clientpw --id.type client -u https://35.233.46.15:7054
set +x

echo '#peer
NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/35-233-46-15-7054.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/35-233-46-15-7054.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/35-233-46-15-7054.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/35-233-46-15-7054.pem
    OrganizationalUnitIdentifier: orderer' >  $FABRIC_CA_CLIENT_HOME/msp/config.yaml

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-ord-ca/rootca/ord-ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$PWD/certs/ordererorg/

set -x
fabric-ca-client enroll -d -u https://admin:adminpw@35.187.18.11:7054
fabric-ca-client register -d --id.name orderer --id.secret ordererpw --id.type orderer -u https://35.187.18.11:7054
set +x

echo '#orderer 
NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/35-187-18-11-7054.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/35-187-18-11-7054.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/35-187-18-11-7054.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/35-187-18-11-7054.pem
    OrganizationalUnitIdentifier: orderer' > $FABRIC_CA_CLIENT_HOME/msp/config.yaml