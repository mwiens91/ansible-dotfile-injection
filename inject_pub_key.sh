#!/usr/bin/env bash

# First argument is meant to be the host, which could either
# be hostname or user@hostname. Either is fine.
if [[ -z $1 ]]
then
    # No argument supplied. Exit.
    echo "Please pass in a hostname or a user@hostname"
    echo "Aborting"
    exit 1
fi

# Second (optional) argument is the public key. It defaults to
# ~/.ssh/id_rsa.pub if the argument is not provided.
if [[ -n $2 ]]
then
    # RSA key path provided
    pub_key_path=$2
else
    # Use the default
    pub_key_path="$HOME/.ssh/id_rsa.pub"
fi

# Check that the public key exists
if [[ ! -r $pub_key_path ]]
then
    # It doesn't
    echo "$pub_key_path either does not exist,"\
         "or does not have read permissions set"
    echo "Aborting"
    exit 1
fi
