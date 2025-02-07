#!/bin/bash
set -e

mkdir -p ~/.dbt
echo "Cloning dbt project from repository..."
git clone --branch "$DBT_REPO_BRANCH" "$DBT_REPO_URL" dbt_project
cd dbt_project

echo "Running dbt command: $DBT_COMMAND"
eval "$DBT_COMMAND" --profiles-dir ./environment/$DBT_ENV