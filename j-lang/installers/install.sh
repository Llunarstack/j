#!/bin/bash
# J Language - Linux/macOS Installer

set -e

INSTALL_DIR="$HOME/.j"
BIN_DIR="$INSTALL_DIR/bin"
EXAMPLES_DIR="$INSTALL_DIR/examples"
SOURCE_BIN="../target/release/j"

echo "Installing J Language..."

# 1. Create Directories
mkdir -p "$BIN_DIR"
mkdir -p "$EXAMPLES_DIR"

# 2. Find Binary
if [ ! -f "$SOURCE_BIN" ]; then
    SOURCE_BIN="./j"
fi

if [ -f "$SOURCE_BIN" ]; then
    cp "$SOURCE_BIN" "$BIN_DIR/j"
    chmod +x "$BIN_DIR/j"
    echo "✅ Binary installed to $BIN_DIR/j"
else
    echo "❌ Error: Could not find 'j' binary. Run 'cargo build --release' first."
    exit 1
fi

# 3. Copy Examples
if [ -d "../examples" ]; then
    cp -r ../examples/* "$EXAMPLES_DIR/"
    echo "✅ Examples installed."
fi

# 4. Add to PATH
SHELL_CONFIG=""
case "$SHELL" in
    */zsh) SHELL_CONFIG="$HOME/.zshrc" ;;
    */bash) SHELL_CONFIG="$HOME/.bashrc" ;;
    *) SHELL_CONFIG="$HOME/.profile" ;;
esac

if [ -n "$SHELL_CONFIG" ]; then
    if ! grep -q "$BIN_DIR" "$SHELL_CONFIG"; then
        echo "" >> "$SHELL_CONFIG"
        echo "# J Language" >> "$SHELL_CONFIG"
        echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$SHELL_CONFIG"
        echo "✅ Added to PATH in $SHELL_CONFIG"
    fi
fi

echo "Installation complete! Please restart your terminal."