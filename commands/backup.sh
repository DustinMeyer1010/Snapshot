cmd_backup() {
    DATE_TIME=$(date +%Y-%m-%d_%H-%M-%S)    
    SNAPSHOT_DIR="$HOME/.snapshot/snapshots/snapshot_$DATE_TIME"
    SOURCE_DIR=$1

    check_for_alias "$SOURCE_DIR"

    mkdir -p "$SNAPSHOT_DIR" || {
        echo "Failed to create snapshot directory $SNAPSHOT_DIR. Please check permissions."
        exit 1
    }

    if [ ! -d "$SOURCE_DIR" ]; then
        echo "Source directory $SOURCE_DIR does not exist."
        exit 1
    fi

    cp -r "$SOURCE_DIR" "$SNAPSHOT_DIR" || {
        echo "Failed to backup $SOURCE_DIR to $SNAPSHOT_DIR. Please check permissions."
        exit 1
    }

    cat > "$SNAPSHOT_DIR/metadata.json" <<EOF
    {
        "id": "$DATE_TIME",
        "source": "$SOURCE_DIR",
        "created": "$(date -Iseconds)",
        "version": 1
    }
EOF

    echo "Backup of $SOURCE_DIR completed successfully!"
}

handle_arguments() {
    echo "Passing Arguments"
}

check_for_alias() {
    local ALIAS_NAME=$1
    local ALIAS_DIR="$HOME/.snapshot/alias"
    local ALIAS_FILE="$ALIAS_DIR/$ALIAS_NAME.conf"

    if [[ -f "$ALIAS_FILE" ]]; then
        echo "Alias found for $ALIAS_NAME. Using alias."
        SOURCE_DIR=$(jq -r '.source' "$ALIAS_FILE")
    fi
}