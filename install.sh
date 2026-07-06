#!/usr/bin/env bash
INSTALL_DIR="$HOME/bin"

mkdir -p "$INSTALL_DIR"

cp -r ../Snapshot/* "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/snapshot"

echo
echo "Installed Snapshot to:"
echo "$INSTALL_DIR/snapshot"
echo
echo "Make sure \$HOME/bin is on your PATH."