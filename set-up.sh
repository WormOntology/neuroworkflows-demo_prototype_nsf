#!/bin/bash

# Step 1: Download Nextflow
curl -s https://get.nextflow.io | bash

# Step 2: Add Nextflow to the PATH environment variable
export PATH=$PATH:$(pwd)

# Step 3: Run Docker Compose
docker compose up -d
