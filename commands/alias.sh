cmd_alias() {
    NAME=$1
    SOURCE_DIR=$2
    ALIAS_DIR="$HOME/.snapshot/alias"
    CONFIG_FILE="$ALIAS_DIR/$NAME.conf"

    if [ -z "$NAME" ] || [ -z "$SOURCE_DIR" ]; then
        echo "Usage: snapshot alias <name> <source_directory>"
        exit 1
    fi

    if [[ -f "$CONFIG_FILE" ]]; then
        echo "Alias '$NAME' already exists. Use a different name."
        exit 1
    fi

    if [ ! -d "$SOURCE_DIR" ]; then
        echo "Source directory $SOURCE_DIR does not exist."
        exit 1
    fi

    cat > "$CONFIG_FILE" <<EOF
    {
        "name": "$NAME",
        "source": "$SOURCE_DIR",
        "exclude": ""
    }
EOF

    echo "Alias '$NAME' created successfully for source directory '$SOURCE_DIR'."

}