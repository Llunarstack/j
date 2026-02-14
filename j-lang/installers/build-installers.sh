#!/bin/bash
# J Language - Master Installer Build Script
# Builds all installers for all platforms

set -e

echo "🚀 J Language - Master Installer Builder"
echo "=========================================="
echo ""

# Parse arguments
BUILD_BINARIES=true
BUILD_DEB=false
BUILD_RPM=false
BUILD_MACOS=false
BUILD_ALL=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --all)
            BUILD_ALL=true
            BUILD_DEB=true
            BUILD_RPM=true
            BUILD_MACOS=true
            shift
            ;;
        --deb)
            BUILD_DEB=true
            shift
            ;;
        --rpm)
            BUILD_RPM=true
            shift
            ;;
        --macos)
            BUILD_MACOS=true
            shift
            ;;
        --skip-binaries)
            BUILD_BINARIES=false
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  --all              Build all installers"
            echo "  --deb              Build Debian package"
            echo "  --rpm              Build RPM package"
            echo "  --macos            Build macOS package"
            echo "  --skip-binaries    Skip binary compilation"
            echo "  --help, -h         Show this help"
            exit 0
            ;;
        *)
            shift
            ;;
    esac
done

# Step 1: Build binaries
if [ "$BUILD_BINARIES" = true ]; then
    echo "📦 Step 1: Building binaries for all platforms..."
    echo ""
    
    if [ -f "build-all-platforms.sh" ]; then
        chmod +x build-all-platforms.sh
        ./build-all-platforms.sh
    else
        echo "❌ build-all-platforms.sh not found"
        exit 1
    fi
    
    echo ""
fi

# Step 2: Build platform-specific installers
echo "📦 Step 2: Building platform-specific installers..."
echo ""

SUCCESS_COUNT=0
FAIL_COUNT=0

# Debian package
if [ "$BUILD_DEB" = true ] || [ "$BUILD_ALL" = true ]; then
    echo "🔨 Building Debian package..."
    if [ -f "build-deb.sh" ]; then
        chmod +x build-deb.sh
        if ./build-deb.sh; then
            echo "✅ Debian package built successfully"
            ((SUCCESS_COUNT++))
        else
            echo "❌ Debian package build failed"
            ((FAIL_COUNT++))
        fi
    else
        echo "⚠️  build-deb.sh not found, skipping"
    fi
    echo ""
fi

# RPM package
if [ "$BUILD_RPM" = true ] || [ "$BUILD_ALL" = true ]; then
    echo "🔨 Building RPM package..."
    if [ -f "build-rpm.sh" ]; then
        chmod +x build-rpm.sh
        if ./build-rpm.sh; then
            echo "✅ RPM package built successfully"
            ((SUCCESS_COUNT++))
        else
            echo "❌ RPM package build failed"
            ((FAIL_COUNT++))
        fi
    else
        echo "⚠️  build-rpm.sh not found, skipping"
    fi
    echo ""
fi

# macOS package
if [ "$BUILD_MACOS" = true ] || [ "$BUILD_ALL" = true ]; then
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "🔨 Building macOS package..."
        if [ -f "build-macos-pkg.sh" ]; then
            chmod +x build-macos-pkg.sh
            if ./build-macos-pkg.sh; then
                echo "✅ macOS package built successfully"
                ((SUCCESS_COUNT++))
            else
                echo "❌ macOS package build failed"
                ((FAIL_COUNT++))
            fi
        else
            echo "⚠️  build-macos-pkg.sh not found, skipping"
        fi
    else
        echo "⚠️  Skipping macOS package (not on macOS)"
    fi
    echo ""
fi

# Summary
echo "=========================================="
echo "📊 Build Summary"
echo "=========================================="
echo ""
echo "Installers built: $SUCCESS_COUNT"
echo "Failed: $FAIL_COUNT"
echo ""

if [ -d "dist/installers" ]; then
    echo "📁 Installers available in: dist/installers/"
    ls -lh dist/installers/ 2>/dev/null || true
    echo ""
fi

echo "✨ Build complete!"
echo ""
echo "Next steps:"
echo "  1. Test installers on target platforms"
echo "  2. Generate checksums: sha256sum dist/installers/* > dist/installers/checksums.txt"
echo "  3. Create GitHub release"
echo "  4. Upload installers to release"
