#!/bin/bash
# J Language - Linux/macOS Installer
# Simple and reliable installer

set -e

# Configuration
VERSION="0.1.0"
INSTALL_DIR="${J_INSTALL_DIR:-$HOME/.j}"
BIN_DIR="$INSTALL_DIR/bin"
EXAMPLES_DIR="$INSTALL_DIR/examples"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo ""
echo -e "${CYAN}================================================${NC}"
echo -e "${CYAN}  J Programming Language Installer v${VERSION}${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""

# Uninstall mode
if [ "$1" = "--uninstall" ]; then
    echo -e "${YELLOW}Uninstalling J...${NC}"
    
    if [ -d "$INSTALL_DIR" ]; then
        rm -rf "$INSTALL_DIR"
        echo -e "${GREEN}Removed: $INSTALL_DIR${NC}"
    fi
    
    # Remove from shell configs
    for rc in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile" "$HOME/.config/fish/config.fish"; do
        if [ -f "$rc" ]; then
            sed -i.bak '/# J Language/,+2d' "$rc" 2>/dev/null || true
        fi
    done
    
    echo ""
    echo -e "${GREEN}J has been uninstalled successfully!${NC}"
    echo -e "${YELLOW}Please restart your terminal.${NC}"
    exit 0
fi

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$OS" in
    linux*)
        OS="linux"
        ;;
    darwin*)
        OS="macos"
        ;;
    *)
        echo -e "${RED}Unsupported OS: $OS${NC}"
        exit 1
        ;;
esac

case "$ARCH" in
    x86_64|amd64)
        ARCH="x86_64"
        ;;
    i686|i386)
        ARCH="i686"
        ;;
    aarch64|arm64)
        ARCH="aarch64"
        ;;
    armv7l)
        ARCH="armv7"
        ;;
    *)
        echo -e "${RED}Unsupported architecture: $ARCH${NC}"
        exit 1
        ;;
esac

PLATFORM="${OS}-${ARCH}"

echo -e "${CYAN}Platform: $PLATFORM${NC}"
echo -e "${CYAN}Install directory: $INSTALL_DIR${NC}"
echo ""

# Find binary
echo -e "${BLUE}Looking for J executable...${NC}"

BINARY_NAME="j-${PLATFORM}"
BINARY_PATH=""

SEARCH_PATHS=(
    "../dist/$BINARY_NAME"
    "dist/$BINARY_NAME"
    "../target/release/j"
    "target/release/j"
    "j"
)

for path in "${SEARCH_PATHS[@]}"; do
    if [ -f "$path" ]; then
        BINARY_PATH="$path"
        echo -e "${GREEN}Found: $path${NC}"
        break
    fi
done

if [ -z "$BINARY_PATH" ]; then
    echo ""
    echo -e "${RED}ERROR: J executable not found!${NC}"
    echo ""
    echo -e "${YELLOW}Please build first:${NC}"
    echo -e "${BLUE}  cd ..${NC}"
    echo -e "${BLUE}  cargo build --release${NC}"
    echo ""
    exit 1
fi

# Create directories
echo -e "${BLUE}Creating directories...${NC}"
mkdir -p "$BIN_DIR"
mkdir -p "$EXAMPLES_DIR"

# Copy binary
echo -e "${BLUE}Installing J executable...${NC}"
cp "$BINARY_PATH" "$BIN_DIR/j"
chmod +x "$BIN_DIR/j"
echo -e "${GREEN}Installed: $BIN_DIR/j${NC}"

# Copy examples
if [ -d "../examples" ]; then
    EXAMPLES_SRC="../examples"
elif [ -d "examples" ]; then
    EXAMPLES_SRC="examples"
fi

if [ -n "$EXAMPLES_SRC" ]; then
    echo -e "${BLUE}Copying examples...${NC}"
    cp -r "$EXAMPLES_SRC"/* "$EXAMPLES_DIR/" 2>/dev/null || true
    echo -e "${GREEN}Copied examples to: $EXAMPLES_DIR${NC}"
fi

# Add to PATH
echo -e "${BLUE}Adding to PATH...${NC}"

SHELL_NAME=$(basename "$SHELL")
case "$SHELL_NAME" in
    bash)
        SHELL_RC="$HOME/.bashrc"
        ;;
    zsh)
        SHELL_RC="$HOME/.zshrc"
        ;;
    fish)
        SHELL_RC="$HOME/.config/fish/config.fish"
        ;;
    *)
        SHELL_RC="$HOME/.profile"
        ;;
esac

if echo "$PATH" | grep -q "$BIN_DIR"; then
    echo -e "${YELLOW}Already in PATH${NC}"
else
    if [ -f "$SHELL_RC" ]; then
        if ! grep -q "J Language" "$SHELL_RC"; then
            echo "" >> "$SHELL_RC"
            echo "# J Language" >> "$SHELL_RC"
            echo "export PATH=\"\$PATH:$BIN_DIR\"" >> "$SHELL_RC"
            echo "export J_HOME=\"$INSTALL_DIR\"" >> "$SHELL_RC"
            echo -e "${GREEN}Added to $SHELL_RC${NC}"
        else
            echo -e "${YELLOW}Already configured in $SHELL_RC${NC}"
        fi
    fi
    
    # Add to current session
    export PATH="$PATH:$BIN_DIR"
    export J_HOME="$INSTALL_DIR"
fi

# Verify installation
echo -e "${BLUE}Verifying installation...${NC}"
if [ -x "$BIN_DIR/j" ]; then
    VERSION_OUTPUT=$("$BIN_DIR/j" --version 2>&1 || echo "unknown")
    echo -e "${GREEN}SUCCESS! J is installed${NC}"
    echo -e "${CYAN}Version: $VERSION_OUTPUT${NC}"
else
    echo -e "${YELLOW}WARNING: Could not verify installation${NC}"
fi

# Show next steps
echo ""
echo -e "${CYAN}================================================${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${CYAN}================================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo ""
echo -e "${NC}1. Restart your terminal or run:${NC}"
echo -e "${BLUE}   source $SHELL_RC${NC}"
echo ""
echo -e "${NC}2. Verify installation:${NC}"
echo -e "${BLUE}   j --version${NC}"
echo ""
echo -e "${NC}3. Start the REPL:${NC}"
echo -e "${BLUE}   j repl${NC}"
echo ""
echo -e "${NC}4. Run an example:${NC}"
echo -e "${BLUE}   j run $EXAMPLES_DIR/basic.j${NC}"
echo ""
echo -e "${NC}5. Create a project:${NC}"
echo -e "${BLUE}   j jolt init my-project${NC}"
echo ""
echo -e "${CYAN}Installation directory: $INSTALL_DIR${NC}"
echo ""
