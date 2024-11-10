#!/bin/bash

MODELS_DIR="public/models"

# Create models directory if it doesn't exist
mkdir -p $MODELS_DIR

# Download face-api.js models
echo "Downloading face-api.js models..."

# List of models to download
MODELS=(
    "face_landmark_68_model-weights_manifest.json"
    "face_landmark_68_model-shard1"
    "face_recognition_model-weights_manifest.json"
    "face_recognition_model-shard1"
    "face_detection_model-weights_manifest.json"
    "face_detection_model-shard1"
)

# Base URL for models
BASE_URL="https://github.com/justadudewhohacks/face-api.js/tree/master/weights"

for MODEL in "${MODELS[@]}"
do
    if [ ! -f "$MODELS_DIR/$MODEL" ]; then
        curl -L "$BASE_URL/$MODEL" -o "$MODELS_DIR/$MODEL"
    fi
done

echo "Models downloaded successfully!"