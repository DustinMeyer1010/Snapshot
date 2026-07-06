cmd_backup() {
    DATE_TIME=$(date +%Y-%m-%d_%H-%M-%S)    
    SNAPSHOT_DIR="$HOME/.snapshot/snapshots/snapshot_$DATE_TIME"

    handle_arguments "$@"

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
    while [[ $# -gt 0 ]]; do
        case $1 in
            --source)
                SOURCE_DIR="$2"
                shift 2
                ;;
            --show)
                show_backups $2
                shift 2
                exit 0
                ;;
            *)
                source_dir="$1"
                ;;
        esac
    done
}


# check to see if the source directory is an alias and if so, use the source directory from the alias
check_for_alias() {
    local ALIAS_NAME=$1
    local ALIAS_DIR="$HOME/.snapshot/alias"
    local ALIAS_FILE="$ALIAS_DIR/$ALIAS_NAME.conf"

    if [[ -f "$ALIAS_FILE" ]]; then
        echo "Alias found for $ALIAS_NAME. Using alias."
        SOURCE_DIR=$(jq -r '.source' "$ALIAS_FILE")
    else 
        SOURCE_DIR=$ALIAS_NAME
    fi


}


show_backups() {
    local SNAPSHOT_DIR="$HOME/.snapshot/snapshots"
    local BACKUP_NAME=$1

    check_for_alias "$BACKUP_NAME"
    found=0

    for meta in $(find "$SNAPSHOT_DIR" -name "metadata.json"); do
        local source=$(jq -r '.source' "$meta")
        local id=$(jq -r '.id' "$meta")
        if [[ "$source" == "$SOURCE_DIR" ]]; then
            found=1
            echo "Backup ID: $id, Source: $source"
        fi
    done

    if [[ $found -eq 0 ]]; then
        echo "No backups found for alias or directory $SOURCE_DIR"
    fi
}