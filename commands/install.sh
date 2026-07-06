#!/usr/bin/env bash
INSTALL_DIR="$HOME/bin"

cmd_install() {

    ARGUMENTS="${1:-install}"

    check_for_dependencies
    check_for_existing_installation

    echo "Creating installation directory at $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR"

    create_snapshot_directory

    if [[ ! -f "$INSTALL_DIR/snapshot" ]]; then
        echo "Failed to install snapshot. Please check permissions on $INSTALL_DIR."
    else
        echo "Snapshot installed successfully!"
    fi

    exit 1
}



check_for_dependencies() {
    if ! command -v jq &> /dev/null; then
        echo "jq is not installed. Please install jq to continue."
        exit 1
    fi
}

check_for_existing_installation() {
    if [[ -f "$INSTALL_DIR/snapshot" ]]; then
        echo "Snapshot is already installed. Use 'reinstall' argument to reinstall."
        exit 1
    fi
}

  create_snapshot_directory() {
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
  }