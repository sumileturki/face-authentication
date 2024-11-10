#!/bin/bash

# scripts/mobile-access.sh
echo "Setting up mobile access..."

# Get local IP address (works on both Linux and macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    LOCAL_IP=$(ipconfig getifaddr en0 || ipconfig getifaddr en1)
else
    # Linux
    LOCAL_IP=$(hostname -I | awk '{print $1}')
fi

# Update vite.config.js to allow external access
cat > vite.config.js << EOF
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 5173,
    https: false, // Set to true if you want HTTPS
    cors: true,
    proxy: {
      '/api': {
        target: 'http://localhost:3000',
        changeOrigin: true,
        secure: false,
      }
    }
  }
})
EOF

echo "✅ Configuration updated!"
echo "📱 To access from your phone:"
echo "1. Make sure your phone is connected to the same WiFi network"
echo "2. Open browser on your phone and visit:"
echo "   http://$LOCAL_IP:5173"