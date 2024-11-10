#!/bin/bash

echo "Setting up react-face-auth project..."

# Install dependencies
npm install

# Create necessary directories
mkdir -p public/models
mkdir -p src/assets/temp

# Download face-api.js models if they don't exist
if [ ! -d "public/models" ]; then
    echo "Downloading face-api.js models..."
    sh ./scripts/download-models.sh
fi

echo "Setup complete!"