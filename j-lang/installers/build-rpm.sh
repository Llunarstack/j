#!/bin/bash
# J Language - RPM Package Builder
# Creates .rpm packages for Fedora/RHEL/CentOS

set -e

VERSION="0.1.0"
RELEASE="1"
ARCH=$(uname -m)
PACKAGE_NAME="j-lang"
BUILD_DIR="build/rpm"
SPEC_FILE="$BUILD_DIR/SPECS/j-lang.spec"

echo "🔨 Building RPM package for $ARCH..."

# Check if rpmbuild is available
if ! command -v rpmbuild &> /dev/null; then
    echo "❌ rpmbuild not found. Install with:"
    echo "   Fedora/RHEL: sudo dnf install rpm-build"
    echo "   CentOS: sudo yum install rpm-build"
    exit 1
fi

# Clean and create build directory structure
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Create source tarball
TARBALL="$BUILD_DIR/SOURCES/j-lang-$VERSION.tar.gz"
mkdir -p "/tmp/j-lang-$VERSION"

# Copy files
if [ -f "dist/j-linux-$ARCH" ]; then
    cp "dist/j-linux-$ARCH" "/tmp/j-lang-$VERSION/j"
elif [ -f "target/release/j" ]; then
    cp "target/release/j" "/tmp/j-lang-$VERSION/j"
else
    echo "❌ Binary not found. Build first with: cargo build --release"
    exit 1
fi

[ -d "examples" ] && cp -r examples "/tmp/j-lang-$VERSION/"
[ -f "README.md" ] && cp README.md "/tmp/j-lang-$VERSION/"
[ -f "LICENSE" ] && cp LICENSE "/tmp/j-lang-$VERSION/"
[ -f "J_lang_logo.ico" ] && cp J_lang_logo.ico "/tmp/j-lang-$VERSION/"

# Create tarball
tar -czf "$TARBALL" -C /tmp "j-lang-$VERSION"
rm -rf "/tmp/j-lang-$VERSION"

# Create spec file
cat > "$SPEC_FILE" << EOF
Name:           j-lang
Version:        $VERSION
Release:        $RELEASE%{?dist}
Summary:        J Programming Language

License:        MIT
URL:            https://github.com/j-lang/j
Source0:        %{name}-%{version}.tar.gz

BuildArch:      $ARCH
BuildRequires:  coreutils

%description
J is a modern, safe, fast, and productive programming language.

Features:
- Fast compilation and execution
- Memory safety without garbage collection
- Rich standard library
- Package manager (Jolt)
- REPL for interactive development

%prep
%setup -q

%build
# Binary is pre-built

%install
rm -rf %{buildroot}

# Install binary
install -D -m 0755 j %{buildroot}%{_bindir}/j

# Install examples
mkdir -p %{buildroot}%{_datadir}/j
[ -d examples ] && cp -r examples %{buildroot}%{_datadir}/j/

# Install documentation
mkdir -p %{buildroot}%{_docdir}/%{name}
[ -f README.md ] && install -m 0644 README.md %{buildroot}%{_docdir}/%{name}/
[ -f LICENSE ] && install -m 0644 LICENSE %{buildroot}%{_docdir}/%{name}/

# Install desktop entry
mkdir -p %{buildroot}%{_datadir}/applications
cat > %{buildroot}%{_datadir}/applications/j-lang.desktop << 'DESKTOP'
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
DESKTOP

# Install icon
mkdir -p %{buildroot}%{_datadir}/icons/hicolor/256x256/apps
[ -f J_lang_logo.ico ] && install -m 0644 J_lang_logo.ico %{buildroot}%{_datadir}/icons/hicolor/256x256/apps/j-lang.png

%files
%{_bindir}/j
%{_datadir}/j
%{_docdir}/%{name}
%{_datadir}/applications/j-lang.desktop
%{_datadir}/icons/hicolor/256x256/apps/j-lang.png

%post
echo "✅ J Language installed successfully!"
echo "   Run 'j --version' to verify installation"
echo "   Run 'j repl' to start the REPL"

%changelog
* $(date "+%a %b %d %Y") J Language Team <team@j-lang.org> - $VERSION-$RELEASE
- Initial release
EOF

# Build RPM
rpmbuild --define "_topdir $PWD/$BUILD_DIR" -ba "$SPEC_FILE"

# Copy to dist
PACKAGE_FILE="$BUILD_DIR/RPMS/$ARCH/j-lang-$VERSION-$RELEASE.*.rpm"
mkdir -p "dist/installers"
cp $PACKAGE_FILE "dist/installers/"

echo "✅ RPM package created: dist/installers/$(basename $PACKAGE_FILE)"
echo ""
echo "Install with:"
echo "  sudo rpm -i dist/installers/$(basename $PACKAGE_FILE)"
echo "  or"
echo "  sudo dnf install dist/installers/$(basename $PACKAGE_FILE)"
