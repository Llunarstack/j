#!/bin/bash
# J Language - macOS Package Builder
# Creates .pkg installer for macOS

set -e

VERSION="0.1.0"
ARCH=$(uname -m)
PACKAGE_NAME="j-lang"
BUILD_DIR="build/macos"
INSTALL_ROOT="$BUILD_DIR/root"
SCRIPTS_DIR="$BUILD_DIR/scripts"

echo "🔨 Building macOS package for $ARCH..."

# Check if we're on macOS
if [[ "$(uname)" != "Darwin" ]]; then
    echo "❌ This script must be run on macOS"
    exit 1
fi

# Check if pkgbuild is available
if ! command -v pkgbuild &> /dev/null; then
    echo "❌ pkgbuild not found. Install Xcode Command Line Tools."
    exit 1
fi

# Clean and create build directory
rm -rf "$BUILD_DIR"
mkdir -p "$INSTALL_ROOT/usr/local/bin"
mkdir -p "$INSTALL_ROOT/usr/local/share/j"
mkdir -p "$INSTALL_ROOT/Applications"
mkdir -p "$SCRIPTS_DIR"

# Copy binary
if [ -f "dist/j-macos-$ARCH" ]; then
    cp "dist/j-macos-$ARCH" "$INSTALL_ROOT/usr/local/bin/j"
    chmod +x "$INSTALL_ROOT/usr/local/bin/j"
elif [ -f "target/release/j" ]; then
    cp "target/release/j" "$INSTALL_ROOT/usr/local/bin/j"
    chmod +x "$INSTALL_ROOT/usr/local/bin/j"
else
    echo "❌ Binary not found. Build first with: cargo build --release"
    exit 1
fi

# Copy examples
if [ -d "examples" ]; then
    cp -r examples "$INSTALL_ROOT/usr/local/share/j/"
fi

# Copy documentation
if [ -d "docs" ]; then
    cp -r docs "$INSTALL_ROOT/usr/local/share/j/"
fi

# Create postinstall script
cat > "$SCRIPTS_DIR/postinstall" << 'EOF'
#!/bin/bash

# Add to PATH in shell profiles
for profile in "$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.profile"; do
    if [ -f "$profile" ]; then
        if ! grep -q "/usr/local/bin" "$profile"; then
            echo 'export PATH="/usr/local/bin:$PATH"' >> "$profile"
        fi
    fi
done

echo "✅ J Language installed successfully!"
echo "   Run 'j --version' to verify installation"
echo "   Run 'j repl' to start the REPL"
echo ""
echo "   Restart your terminal or run:"
echo "   source ~/.zshrc"

exit 0
EOF

chmod +x "$SCRIPTS_DIR/postinstall"

# Build component package
COMPONENT_PKG="$BUILD_DIR/j-lang-component.pkg"
pkgbuild --root "$INSTALL_ROOT" \
         --scripts "$SCRIPTS_DIR" \
         --identifier "org.j-lang.j" \
         --version "$VERSION" \
         --install-location "/" \
         "$COMPONENT_PKG"

# Create distribution XML
DISTRIBUTION_XML="$BUILD_DIR/distribution.xml"
cat > "$DISTRIBUTION_XML" << EOF
<?xml version="1.0" encoding="utf-8"?>
<installer-gui-script minSpecVersion="1">
    <title>J Programming Language</title>
    <organization>org.j-lang</organization>
    <domains enable_localSystem="true"/>
    <options customize="never" require-scripts="false" hostArchitectures="$ARCH"/>
    
    <welcome file="welcome.html" mime-type="text/html"/>
    <license file="LICENSE"/>
    <readme file="README.md"/>
    
    <pkg-ref id="org.j-lang.j"/>
    
    <options customize="never" require-scripts="false"/>
    
    <choices-outline>
        <line choice="default">
            <line choice="org.j-lang.j"/>
        </line>
    </choices-outline>
    
    <choice id="default"/>
    
    <choice id="org.j-lang.j" visible="false">
        <pkg-ref id="org.j-lang.j"/>
    </choice>
    
    <pkg-ref id="org.j-lang.j" version="$VERSION" onConclusion="none">j-lang-component.pkg</pkg-ref>
</installer-gui-script>
EOF

# Create welcome HTML
cat > "$BUILD_DIR/welcome.html" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Helvetica, Arial, sans-serif; }
        h1 { color: #007AFF; }
    </style>
</head>
<body>
    <h1>Welcome to J Programming Language</h1>
    <p>This installer will install J on your Mac.</p>
    <p><strong>Features:</strong></p>
    <ul>
        <li>Fast compilation and execution</li>
        <li>Memory safety without garbage collection</li>
        <li>Rich standard library</li>
        <li>Package manager (Jolt)</li>
        <li>REPL for interactive development</li>
    </ul>
</body>
</html>
EOF

# Copy LICENSE and README
[ -f "LICENSE" ] && cp LICENSE "$BUILD_DIR/"
[ -f "README.md" ] && cp README.md "$BUILD_DIR/"

# Build product package
PACKAGE_FILE="dist/installers/j-lang-$VERSION-$ARCH.pkg"
mkdir -p "dist/installers"

productbuild --distribution "$DISTRIBUTION_XML" \
             --resources "$BUILD_DIR" \
             --package-path "$BUILD_DIR" \
             "$PACKAGE_FILE"

echo "✅ macOS package created: $PACKAGE_FILE"
echo ""
echo "Install with:"
echo "  sudo installer -pkg $PACKAGE_FILE -target /"
echo "  or double-click the .pkg file"
