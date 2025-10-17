#!/bin/bash
# Quick setup script for Ollama local AI
# Run this when you want to use local AI instead of cloud providers

set -e

echo "🏠 Setting up Ollama for local AI in Neovim..."
echo ""

# Check if Ollama is installed
if ! command -v ollama &> /dev/null; then
    echo "📦 Ollama not found. Installing via Homebrew..."
    brew install ollama
else
    echo "✅ Ollama is already installed"
fi

echo ""
echo "🚀 Starting Ollama service in background..."
# Start ollama serve in background if not running
if ! pgrep -x "ollama" > /dev/null; then
    nohup ollama serve > /tmp/ollama.log 2>&1 &
    sleep 2
    echo "✅ Ollama service started (logs: /tmp/ollama.log)"
else
    echo "✅ Ollama service already running"
fi

echo ""
echo "📥 Pulling recommended coding model..."
echo "   This will download ~4.7GB (qwen2.5-coder:7b)"
echo ""

# Pull the recommended model
ollama pull qwen2.5-coder:7b

echo ""
echo "✅ Setup complete!"
echo ""
echo "🎯 How to use:"
echo "   1. Open Neovim"
echo "   2. Press <Space>ao to toggle between Cloud and Local AI"
echo "   3. Or use :AvanteSwitch ollama"
echo ""
echo "📚 Other good models to try:"
echo "   ollama pull llama3.1             # General purpose (4.7GB)"
echo "   ollama pull deepseek-coder-v2    # Coding specialist (8.9GB)"
echo "   ollama pull codellama:13b        # Larger coding model (7.4GB)"
echo ""
echo "🔍 Check running models: ollama list"
echo "🛑 Stop Ollama service: killall ollama"
