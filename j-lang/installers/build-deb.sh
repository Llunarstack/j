#!/bin/bash
# J Language - Debian Package Builder
# Creates .deb packages for Ubuntu/Debian

set -e

VERSION="0.1.0"
ARCH=$(dpkg --print-architecture)
PACKAGE_NAME="j-lang"
BUILD_DIR="build/deb"

echo "🔨 Building Debian package for $ARCH..."

# Clean and create build directory
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR/DEBIAN"
mkdir -p "$BUILD_DIR/usr/bin"
mkdir -p "$BUILD_DIR/usr/share/j"
mkdir -p "$BUILD_DIR/usr/share/applications"
mkdir -p "$BUILD_DIR/usr/share/icons/hicolor/256x256/apps"
mkdir -p "$BUILD_DIR/usr/share/doc/j-lang"

# Copy binary
if [ -f "dist/j-linux-$ARCH" ]; then
    cp "dist/j-linux-$ARCH" "$BUILD_DIR/usr/bin/j"
    chmod +x "$BUILD_DIR/usr/bin/j"
elif [ -f "target/release/j" ]; then
    cp "target/release/j" "$BUILD_DIR/usr/bin/j"
    chmod +x "$BUILD_DIR/usr/bin/j"
else
    echo "❌ Binary not found. Build first with: cargo build --release"
    exit 1
fi

# Copy examples
if [ -d "examples" ]; then
    cp -r examples "$BUILD_DIR/usr/share/j/"
fi

# Copy documentation
if [ -f "README.md" ]; then
    cp README.md "$BUILD_DIR/usr/share/doc/j-lang/"
fi

if [ -f "LICENSE" ]; then
    cp LICENSE "$BUILD_DIR/usr/share/doc/j-lang/copyright"
fi

# Create control file
cat > "$BUILD_DIR/DEBIAN/control" << EOF
Package: $PACKAGE_NAME
Version: $VERSION
Section: devel
Priority: optional
Architecture: $ARCH
Maintainer: J Language Team <team@j-lang.org>
Description: J Programming Language
 J is a modern, safe, fast, and productive programming language.
 .
 Features:
  - Fast compilation and execution
  - Memory safety without garbage collection
  - Rich standard library
  - Package manager (Jolt)
  - REPL for interactive development
Homepage: https://github.com/j-lang/j
EOF

# Create postinst script
cat > "$BUILD_DIR/DEBIAN/postinst" << 'EOF'
#!/bin/bash
set -e

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database -q
fi

# Update icon cache
if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -q -t -f /usr/share/icons/hicolor
fi

echo "✅ J Language installed successfully!"
echo "   Run 'j --version' to verify installation"
echo "   Run 'j repl' to start the REPL"

exit 0
EOF

chmod +x "$BUILD_DIR/DEBIAN/postinst"

# Create postrm script
cat > "$BUILD_DIR/DEBIAN/postrm" << 'EOF'
#!/bin/bash
set -e

# Update desktop database
if command -v update-desktop-database &> /dev/null; then
    update-desktop-database -q
fi

# Update icon cache
if command -v gtk-update-icon-cache &> /dev/null; then
    gtk-update-icon-cache -q -t -f /usr/share/icons/hicolor
fi

exit 0
EOF

chmod +x "$BUILD_DIR/DEBIAN/postrm"

# Create desktop entry
cat > "$BUILD_DIR/usr/share/applications/j-lang.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=J REPL
Comment=J Programming Language REPL
Exec=j repl
Icon=j-lang
Terminal=true
Categories=Development;IDE;
Keywords=programming;language;repl;
EOF

# Copy icon (convert from .ico if needed)
if [ -f "J_lang_logo.ico" ]; then
    # If ImageMagick is available, convert ico to png
    if command -v convert &> /dev/null; then
        convert "J_lang_logo.ico[0]" "$BUILD_DIR/usr/share/icons/hicolor/256x256/apps/j-lang.png"
    else
        cp "J_lang_logo.ico" "$BUILD_DIR/usr/share/icons/hicolor/256x256/apps/j-lang.png"
    fi
fi

# Build package
PACKAGE_FILE="dist/installers/${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"
mkdir -p "dist/installers"

dpkg-deb --build "$BUILD_DIR" "$PACKAGE_FILE"

echo "✅ Debian package created: $PACKAGE_FILE"
echo ""
echo "Install with:"
echo "  sudo dpkg -i $PACKAGE_FILE"
echo "  sudo apt-get install -f  # Install dependencies if needed"
