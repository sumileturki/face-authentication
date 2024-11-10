#!/bin/bash

echo "Starting production server..."

# Build the project
npm run build

# Start the preview server
npm run preview

echo "Server started!"