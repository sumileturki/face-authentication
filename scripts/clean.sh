#!/bin/bash

echo "Cleaning project..."

# Remove build artifacts
rm -rf dist/
rm -rf src/assets/temp/*

# Remove node modules (optional)
# rm -rf node_modules/

echo "Clean complete!"