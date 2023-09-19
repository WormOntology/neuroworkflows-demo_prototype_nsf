#!/bin/bash

# Check if Nextflow is installed
if ! command -v nextflow &> /dev/null
then
    # If Nextflow is not installed, download and install it
    curl -s https://get.nextflow.io | bash
    # Add Nextflow to the PATH environment variable
    export PATH=$PATH:$(pwd)
else
    echo "Nextflow is already installed"
fi

# Run Docker Compose
docker compose up -d
