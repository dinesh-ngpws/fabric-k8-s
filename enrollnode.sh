#!/bin/bash

function orderer() {
    echo "####### ENROLLING ORDERER #########"

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-ord-ca/rootca/ord-ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$PWD/certs/ordererorg/orderer
export FABRIC_CA_CLIENT_MSPDIR=msp
set -x
fabric-ca-client enroll -d -u https://orderer:ordererpw@35.187.18.11:7054
set +x


echo "moving the config file"
cp $PWD/certs/ordererorg/msp/config.yaml $FABRIC_CA_CLIENT_HOME/msp/config.yaml

echo "changing the root ca"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-tls-ca/rootca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_MSPDIR=tls
set -x
fabric-ca-client enroll -d -u https://orderer:ordererpw@34.78.133.32:7054 --enrollment.profile tls --csr.hosts orderer --csr.hosts localhost
set +x

cp  $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/tls/ca.crt
cp  $FABRIC_CA_CLIENT_HOME/tls/signcerts/* $FABRIC_CA_CLIENT_HOME/tls/server.crt
cp  $FABRIC_CA_CLIENT_HOME/tls/keystore/* $FABRIC_CA_CLIENT_HOME/tls/server.key

echo "editing the ord-ca admin tlscerts "

mkdir $PWD/certs/ordererorg/msp/tlscacerts
cp $FABRIC_CA_CLIENT_HOME/tls/ca.crt $PWD/certs/ordererorg/msp/tlscacerts/ca.cert

echo "editing the orderer root tlsca directory"

mkdir $PWD/certs/ordererorg/tlsca
cp $FABRIC_CA_CLIENT_HOME/tls/ca.crt $PWD/certs/ordererorg/tlsca/tls-ca.cert

echo "editing root ca directory"

mkdir $PWD/certs/ordererorg/ca
cp $FABRIC_CA_CLIENT_HOME/msp/cacerts/* $PWD/certs/ordererorg/ca/orderer-ca.cert

}

function peer(){
    echo "####### ENROLLING PEER #########"

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-org-ca/rootca/org-ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$PWD/certs/peerorg/peer
export FABRIC_CA_CLIENT_MSPDIR=msp
set -x
fabric-ca-client enroll -d -u https://peer-org:peerpw@35.233.46.15:7054
set +x

echo "moving the config file"
cp $PWD/certs/peerorg/msp/config.yaml $FABRIC_CA_CLIENT_HOME/msp/config.yaml

echo "changing the root ca"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-tls-ca/rootca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_MSPDIR=tls
set -x
fabric-ca-client enroll -d -u https://peer-org:peerpw@34.78.133.32:7054 --enrollment.profile tls --csr.hosts peer-org --csr.hosts localhost
set +x

cp  $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/tls/ca.crt
cp  $FABRIC_CA_CLIENT_HOME/tls/signcerts/* $FABRIC_CA_CLIENT_HOME/tls/server.crt
cp  $FABRIC_CA_CLIENT_HOME/tls/keystore/* $FABRIC_CA_CLIENT_HOME/tls/server.key

echo "editing the ord-ca admin tlscerts "

mkdir $PWD/certs/peerorg/msp/tlscacerts
cp $FABRIC_CA_CLIENT_HOME/tls/ca.crt $PWD/certs/peerorg/msp/tlscacerts/ca.cert

echo "editing the orderer root tlsca directory"

mkdir $PWD/certs/peerorg/tlsca
cp $FABRIC_CA_CLIENT_HOME/tls/ca.crt $PWD/certs/peerorg/tlsca/tls-ca.crt

echo "editing root ca directory"
mkdir $PWD/certs/peerorg/ca
cp $FABRIC_CA_CLIENT_HOME/msp/cacerts/* $PWD/certs/peerorg/ca/peerorg-ca.cert

}

function cli(){
    echo "####### ENROLLING PEER ADMIN #########"

export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-org-ca/rootca/org-ca-cert.pem
export FABRIC_CA_CLIENT_HOME=$PWD/certs/peerorg/admin
export FABRIC_CA_CLIENT_MSPDIR=msp
set -x
fabric-ca-client enroll -d -u https://admin-org:adminpw@35.233.46.15:7054
set +x

echo "moving the config file"
cp $PWD/certs/peerorg/msp/config.yaml $FABRIC_CA_CLIENT_HOME/msp/config.yaml

echo "changing the root ca"
export FABRIC_CA_CLIENT_TLS_CERTFILES=$PWD/deploy-tls-ca/rootca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_MSPDIR=tls
set -x
fabric-ca-client enroll -d -u https://admin-org:adminpw@34.78.133.32:7054 --enrollment.profile tls --csr.hosts admin-org --csr.hosts localhost
set +x

cp  $FABRIC_CA_CLIENT_HOME/tls/tlscacerts/* $FABRIC_CA_CLIENT_HOME/tls/ca.crt
cp  $FABRIC_CA_CLIENT_HOME/tls/signcerts/* $FABRIC_CA_CLIENT_HOME/tls/server.crt
cp  $FABRIC_CA_CLIENT_HOME/tls/keystore/* $FABRIC_CA_CLIENT_HOME/tls/server.key
}


orderer

peer

cli