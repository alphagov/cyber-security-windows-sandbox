#!/bin/bash
FOLDER=$1
KEYPAIR_NAME=$2
mkdir -p $FOLDER
private="${FOLDER}/${KEYPAIR_NAME}"
public="${private}.pub"
mv $private "${private}.old"
mv $public "${public}.old"
secret=$(aws secretsmanager get-secret-value --secret-id=$KEYPAIR_NAME)
secret_value=$(echo $secret | jq -r .SecretString)
private_key=$(echo $secret_value | jq -r .private)
public_key=$(echo $secret_value | jq -r .public)
echo $private_key > $private
echo $public_key > $public
echo $public
cat $public
