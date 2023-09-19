# BossDB x DataJoint x NextFlow Demo

This repo is a example of how to use nextflow to quickly run scalable and containerized workflows.

## Whats included

- Example of a containarized workflow that finds segment centroids for from a segmentation volume and adds it to a locally-deployed DataJoint database.
- Configuration settings and docker images to allow for easy customization or templating of this repo for other projects.

## Requirements

1. docker and docker-compose
2. `curl` to download nextflow

## Getting Started

Simple run the `set-up.sh` script to install nextflow, add it to your path, and run the docker-compose YAML.

