#!/bin/bash
# J Language - Cross-Platform Build Script (Linux/macOS)
# Builds binaries for all supported platforms and architectures

set -e

echo "🚀 J Language - Multi-Platform Build System"
echo "============================================="
echo ""

# Check if cross is installed
if ! command -v cross &> /dev/null; then
    echo "⚠️  'cross' not found. Installing..."
    cargo install cross --git https://github.com/cross-rs/cross
fi

# Check if cargo is installed
if ! command -v cargo &> /dev/null; then
    echo "❌ Cargo not found. Please install Rust from https://rustup.rs/"
    exit 1
fi

# Parse arguments
RELEASE=true
SKIP_TESTS=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --debug)
            RELEASE=false
            shift
            ;;
        --skip-tests)
            SKIP_TESTS=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Create output directory
OUTPUT_DIR="dist"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

# Define target platforms
declare -a TARGETS=(
    "windows-x86_64:x86_64-pc-windows-gnu:.exe"
    "windows-i686:i686-pc-windows-gnu:.exe"
    "linux-x86_64:x86_64-unknown-linux-gnu:"
    "linux-i686:i686-unknown-linux-gnu:"
    "linux-aarch64:aarch64-unknown-linux-gnu:"
    "linux-armv7:armv7-unknown-linux-gnueabihf:"
    "linux-arm:arm-unknown-linux-gnueabihf:"
    "macos-x86_64:x86_64-apple-darwin:"
    "macos-aarch64:aarch64-apple-darwin:"
    "freebsd-x86_64:x86_64-unknown-freebsd:"
)

BUILD_MODE="release"
BUILD_FLAG="--release"

if [ "$RELEASE" = false ]; then
    BUILD_MODE="debug"
    BUILD_FLAG=""
fi

echo "📦 Building for ${#TARGETS[@]} platforms..."
echo "   Build mode: $BUILD_MODE"
echo ""

SUCCESS_COUNT=0
FAIL_COUNT=0

for target_info in "${TARGETS[@]}"; do
    IFS=':' read -r NAME TARGET EXT <<< "$target_info"
    
    echo "🔨 Building: $NAME ($TARGET)..."
    
    # Add target if not already added
    rustup target add "$TARGET" 2>/dev/null || true
    
    # Build
    if [[ "$TARGET" == *"darwin"* ]] && [[ "$(uname)" != "Darwin" ]]; then
        echo "   ⚠️  Skipping macOS target on non-macOS system"
        continue
    fi
    
    if [[ "$TARGET" == *"windows"* ]] || [[ "$TARGET" == *"linux"* ]] || [[ "$TARGET" == *"freebsd"* ]]; then
        cross build $BUILD_FLAG --target "$TARGET" 2>&1 | grep -v "warning" || true
    else
        cargo build $BUILD_FLAG --target "$TARGET" 2>&1 | grep -v "warning" || true
    fi
    
    # Check if build succeeded
    BINARY_PATH="target/$TARGET/$BUILD_MODE/j$EXT"
    if [ -f "$BINARY_PATH" ]; then
        # Copy to dist
        DIST_PATH="$OUTPUT_DIR/j-$NAME$EXT"
        cp "$BINARY_PATH" "$DIST_PATH"
        
        # Get file size
        SIZE=$(du -h "$DIST_PATH" | cut -f1)
        
        echo "   ✅ Success! Size: $SIZE"
        ((SUCCESS_COUNT++))
    else
        echo "   ❌ Failed: Binary not found"
        ((FAIL_COUNT++))
    fi
    
    echo ""
done

# Summary
echo "============================================="
echo "📊 Build Summary"
echo "============================================="
echo ""
echo "Total: $SUCCESS_COUNT succeeded, $FAIL_COUNT failed"
echo ""
echo "📁 Binaries available in: $OUTPUT_DIR/"
echo ""

# Create checksums
if [ $SUCCESS_COUNT -gt 0 ]; then
    echo "🔐 Generating checksums..."
    CHECKSUM_FILE="$OUTPUT_DIR/checksums.txt"
    cd "$OUTPUT_DIR"
    sha256sum j-* > checksums.txt
    cd ..
    echo "   ✅ Checksums saved to: checksums.txt"
    echo ""
fi

echo "✨ Build complete!"
