#!/bin/bash

echo "Starting the build process..."

echo "Installing dependencies..."
python3.10 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install "meltano"

echo "Starting Docker Compose..."
docker compose -f code-main/docker-compose.yml up -d

export RUN_DATE=$(date +\%Y-\%m-\%d)

echo "Running pipeline step 1: Northwind and csv to local disk"
meltano run pipe-step1-details
meltano run pipe-step1-northwind

echo "Running pipeline step 2: from local disk to Postgres"
meltano run pipe-step2-details
meltano run pipe-step2-northwind
# To execute a specific step of the pipeline individually, you need to set the RUN_DATE environment variable.
# Example:
# RUN_DATE="2024-11-09" meltano run pipe-step2-northwind
# RUN_DATE="2024-11-09" meltano run pipe-step2-details

echo "Building dbt models..."
meltano invoke dbt-postgres:build

echo "Final analyses of orders and it's details calculated and stored in the final database, in schema analytics"
