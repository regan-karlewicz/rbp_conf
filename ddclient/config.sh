#!/bin/bash

if ! [ -x "$(command -v aws)" ]; then
  echo "Error: aws is not installed." >&2
  exit 1
fi

if ! [ -x "$(command -v jq)" ]; then
  echo "Error: jq is not installed." >&2
  exit 1
fi


STARTING_REGION=$(aws configure get region)
aws configure set region us-west-2

function safe_exit() {
  aws configure set region "$STARTING_REGION"
  exit "$1"
}

COMMAND=$1

if [ "$COMMAND" = "save" ]; then 
  if ! [ -f "$(dirname "$0")/config.json" ]; then
    echo "Error: config.json does not exist." >&2
    safe_exit 1
  fi

  echo "Saving config.json..."
  aws ssm put-parameter --name homebridge-config --value "$(< "$(dirname "$0")/config.json" jq -c)" --type SecureString --overwrite
  safe_exit 0
elif [ "$COMMAND" = "download" ]; then
  echo "Downloading config.json..."
  aws ssm get-parameter --name homebridge-config --with-decryption --output text --query Parameter.Value | jq > "$(dirname "$0")/config.json"
  safe_exit 0
fi

echo "Invalid command, valid commands are 'save' or 'download'."
safe_exit 1
