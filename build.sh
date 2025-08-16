#!/bin/bash

image_name=$1
project_id=$2

if [ -z "$image_name" ]; then
    echo -e "\033[31m❌ Missing image-name, usage: ./build.sh <image-name> <project-id>\033[0m"
    exit 1
fi

if [ -z "$project_id" ]; then
    echo -e "\033[31m❌ Missing project-id, usage: ./build.sh <image-name> <project-id>\033[0m"
    exit 1
fi

echo -e "\033[32m🚀 Building image $image_name in project $project_id\033[0m"

# Set gcloud CLI to use the project
gcloud config set project $project_id

# Working directory
cd $image_name

# Build the Docker image
gcloud builds submit --config cloudbuild.yaml . --project $project_id

# View the image in Google Container Registry
gcloud container images list --filter $image_name --project $project_id