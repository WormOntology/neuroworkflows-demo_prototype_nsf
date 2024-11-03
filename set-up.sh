#!/bin/bash

# Check if Nextflow is installed
if ! command -v nextflow &> /dev/null
then
    # If Nextflow is not installed, download and install it
    curl -s https://get.nextflow.io | bash
    # Add Nextflow to the PATH environment variable
    export PATH=$PATH:$(pwd)
elsed
    echo "Nextflow is already installed"
fi

# Run Docker Compose
# JPN prune to restart
docker-compose down -v --rmi all --remove-orphans
docker compose up -d 
# JPN
#docker compose up --platform linux/arm64 -d 
