#! /bin/bash
if [[ $# -lt 2 ]]; then
  echo "Usage: create_keypair.sh directory keypair_name"
else
  FOLDER=$1
  KEYPAIR_NAME=$2
  mkdir -p $FOLDER
  private="${FOLDER}/${KEYPAIR_NAME}"
  public="${private}.pub"
  mv $private "${private}.old"
  mv $public "${public}.old"
  openssl genrsa -out $private 2048
  chmod 400 $private
  ssh-keygen -y -f $private > $public
fi
