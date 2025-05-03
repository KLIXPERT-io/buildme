#!/bin/bash

echo "🔍 Searching for .buildme files..."
# Removing the -not -path "*/\.*" which might exclude the .buildme files themselves
BUILDME_FILES=$(find . -name ".buildme" -not -path "*/node_modules/*" -type f)

if [ -z "$BUILDME_FILES" ]; then
  echo "ℹ️ No .buildme files found."
  echo "Debug: Current directory: $(pwd)"
  echo "Debug: Files in current directory: $(ls -la)"
  exit 0
fi

echo "🔎 Found .buildme files:"
echo "$BUILDME_FILES"

for FILE in $BUILDME_FILES; do
  DIR=$(dirname "$FILE")
  echo "📂 Processing directory: $DIR"
  
  if [ -f "$DIR/package.json" ]; then
    echo "📦 Found package.json in $DIR"
    echo "🔧 Installing dependencies..."
    cd "$DIR"
    npm install
    
    echo "🏗️ Building project..."
    npm run build
    
    echo "🧹 Cleaning up node_modules..."
    rm -rf node_modules
    
    # Return to the original directory
    cd - > /dev/null
    
    echo "✅ Completed building $DIR"
  else
    echo "⚠️ No package.json found in $DIR, skipping."
  fi
done

echo "🎉 Build process completed!"