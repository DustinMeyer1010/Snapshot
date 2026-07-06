#!/usr/bin/env bash
INSTALL_DIR="$HOME/bin"

if [[ -f "$INSTALL_DIR/snapshot" && $1 != "reinstall" ]]; then
    echo "Snapshot already installed"
    exit 1
fi

echo "Creating installation directory at $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

echo "Installing Snapshot to $INSTALL_DIR"
cp -r ../Snapshot/* "$INSTALL_DIR/" || {
    echo "Failed to copy Snapshot files to $INSTALL_DIR. Please check permissions."
    exit 1
}

echo "Copied Snapshot files to $INSTALL_DIR"


echo "Setting permissions for snapshot..."
chmod +x "$INSTALL_DIR/snapshot" || {
    echo "Failed to set permissions for snapshot. Please check permissions on $INSTALL_DIR."
    exit 1
}

echo "Permissions set for snapshot"


if [[ ! -f "$INSTALL_DIR/snapshot" ]]; then
    echo "Failed to install snapshot. Please check permissions on $INSTALL_DIR."
else
    echo "Snapshot installed successfully!"
fi

exit 1