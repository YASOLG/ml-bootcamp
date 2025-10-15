#!/bin/bash
#
# ML Bootcamp Universal Installer
# One-line install: curl -sSL https://raw.githubusercontent.com/DandaAkhilReddy/ml-bootcamp/main/install.sh | bash
#

set -e

REPO_URL="https://github.com/DandaAkhilReddy/ml-bootcamp.git"
INSTALL_DIR="$HOME/ml-bootcamp"

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║          ML BOOTCAMP - Universal Installer                    ║"
echo "║      Learn Machine Learning in 10 Days - Completely Free!     ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Error: git is not installed!"
    echo "Please install git first:"
    echo "  - Ubuntu/Debian: sudo apt-get install git"
    echo "  - macOS: brew install git  (or install Xcode Command Line Tools)"
    echo "  - Windows: Download from https://git-scm.com/download/win"
    exit 1
fi

# Check if Python is installed
if command -v python3 &> /dev/null; then
    PYTHON_CMD=python3
    PIP_CMD=pip3
elif command -v python &> /dev/null; then
    PYTHON_CMD=python
    PIP_CMD=pip
else
    echo "❌ Error: Python is not installed!"
    echo "Please install Python 3.8+ from https://python.org"
    exit 1
fi

echo "✅ Python found: $($PYTHON_CMD --version)"
echo ""

# Clone repository
echo "📥 Cloning ML Bootcamp repository..."
if [ -d "$INSTALL_DIR" ]; then
    echo "⚠️  Directory $INSTALL_DIR already exists!"
    read -p "Do you want to remove it and reinstall? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$INSTALL_DIR"
    else
        echo "Installation cancelled."
        exit 0
    fi
fi

git clone "$REPO_URL" "$INSTALL_DIR"
cd "$INSTALL_DIR"
echo "✅ Repository cloned successfully"
echo ""

# Install dependencies
echo "📦 Installing Python dependencies..."
$PIP_CMD install -r requirements.txt --quiet
echo "✅ Dependencies installed"
echo ""

# Initialize database
echo "🗄️  Initializing database..."
$PYTHON_CMD init_db.py
echo "✅ Database initialized"
echo ""

echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║            🎉 INSTALLATION COMPLETE! 🎉                       ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
echo ""
echo "  ML Bootcamp has been installed to: $INSTALL_DIR"
echo ""
echo "  To start learning:"
echo "    cd $INSTALL_DIR"
echo "    $PYTHON_CMD app.py"
echo ""
echo "  Then open your browser to: http://localhost:5000"
echo ""
echo "  Or use the quick-start script:"
echo "    cd $INSTALL_DIR"
echo "    ./quick-start.sh"
echo ""
echo "╔═══════════════════════════════════════════════════════════════╗"
echo "║              Happy Learning! 🎓✨                              ║"
echo "╚═══════════════════════════════════════════════════════════════╝"
