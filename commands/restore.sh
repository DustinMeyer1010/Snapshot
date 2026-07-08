cmd_restore() {
    local SNAPSHOT_DIR="$HOME/.snapshot/snapshots"
    SOURCE_DIR=$1
    SNAPSHOT=$2

    check_for_alias "$SOURCE_DIR"

    FOUND_SNAPSHOT=""

    for meta in $(find "$SNAPSHOT_DIR" -name "metadata.json"); do
        local source=$(jq -r '.source' "$meta")
        local id=$(jq -r '.id' "$meta")

        if [[ "$source" == "$SOURCE_DIR" && $id == "$SNAPSHOT"  ]]; then
            FOUND_SNAPSHOT=("$(printf "%S" "$id")")
            break
        fi
    done

    if [[ $FOUND_SNAPSHOT == "" ]]; then
        echo "No Snapshot found"
        exit 0 
    fi

    cp -r $HOME"/.snapshot/snapshots/snapshot_$FOUND_SNAPSHOT/Snapshot" "$SOURCE_DIR/SNAPSHOT_BACKUP_$FOUND_SNAPSHOT"


    
}