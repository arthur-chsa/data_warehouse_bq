#!/bin/bash
set -e

# Set configuration paths
ENV_FILE_PATH="/config/.env"
SERVICE_ACCOUNT_KEY_PATH="/config/service-account-key.json"

# Read configurations from the .env file
if [ -f "$ENV_FILE_PATH" ]; then
  export $(grep -v '^#' $ENV_FILE_PATH | xargs)
else
  echo "ERROR: .env file not found at $ENV_FILE_PATH"
  exit 1
fi

# Run gcloud authentication
if [ -f "$SERVICE_ACCOUNT_KEY_PATH" ]; then
  gcloud auth activate-service-account --key-file="$SERVICE_ACCOUNT_KEY_PATH"
  export GOOGLE_APPLICATION_CREDENTIALS="$SERVICE_ACCOUNT_KEY_PATH"
  echo "Authentication successful. GOOGLE_APPLICATION_CREDENTIALS set to $SERVICE_ACCOUNT_KEY_PATH"
else
  echo "ERROR: Service account key file not found at $SERVICE_ACCOUNT_KEY_PATH"
  exit 1
fi

# Ensure repo URL is valid
if [ -z "$DBT_PROJECT_REPO" ]; then
  echo "ERROR: Missing DBT_PROJECT_REPO in config.json"
  exit 1
fi

# Clone the dbt project repo
if [ ! -z "$GITHUB_TOKEN" ]; then
  DBT_PROJECT_REPO=$(echo "$DBT_PROJECT_REPO" | sed "s|https://|https://$GITHUB_TOKEN@|")
fi

echo "Cloning repo: $DBT_PROJECT_REPO (branch: $DBT_PROJECT_BRANCH)..."
git clone --branch "$DBT_PROJECT_BRANCH" "$DBT_PROJECT_REPO" repo
cd repo

# Use provided command or fallback to default from config.json
if [ $# -gt 0 ]; then
  DBT_COMMAND="$@"
else
  echo "ERROR: Missing dbt command"
  exit 1
fi

echo "Running command: $DBT_COMMAND --profiles-dir ./environment/$DBT_ENV"
eval "$DBT_COMMAND --profiles-dir ./environment/$DBT_ENV"