#!/bin/bash
# Unlock Music CLI - Quick Install Script
# For Hermes Agent integration on Termux/Android

set -e

INSTALL_DIR="${HOME}/.local/bin"
BINARY_NAME="um"

echo "=== Unlock Music CLI Installer ==="

# Check Go
if ! command -v go &>/dev/null; then
    echo "Installing Go..."
    pkg install golang -y
fi

echo "Go version: $(go version)"

# Build from source
echo "Building unlock-music CLI..."
export GOPROXY=https://goproxy.io,direct
TMPDIR=$(mktemp -d)
cd "$TMPDIR"

# Try go install first
if go install git.um-react.app/um/cli/cmd/um@main 2>/dev/null; then
    echo "Built via go install"
    BUILT_BINARY="$(go env GOPATH)/bin/um"
else
    # Fallback: build from local repo
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    cd "$SCRIPT_DIR"
    go build -o "$TMPDIR/$BINARY_NAME" ./cmd/um
    BUILT_BINARY="$TMPDIR/$BINARY_NAME"
    echo "Built from local source"
fi

# Install
mkdir -p "$INSTALL_DIR"
cp "$BUILT_BINARY" "$INSTALL_DIR/$BINARY_NAME"
chmod +x "$INSTALL_DIR/$BINARY_NAME"

# Cleanup
rm -rf "$TMPDIR"

echo ""
echo "=== Installation Complete ==="
echo "Binary: $INSTALL_DIR/$BINARY_NAME"
echo "Version: $($INSTALL_DIR/$BINARY_NAME --version 2>/dev/null || echo 'unknown')"
echo ""
echo "Usage: um -o <output_dir> <input_file_or_dir>"
echo ""
echo "Make sure $INSTALL_DIR is in your PATH:"
echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
