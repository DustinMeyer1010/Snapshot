cmd_init() {
    if [ -d ~/.snapshot ]; then
        echo "Snapshot directory already exists."
        exit 1
    fi
    mkdir -p ./.snapshot/snapshots
    mkdir -p ./.snapshot/logs
    mkdir -p ./.snapshot/config
    mkdir -p ./.snapshot/profiles
}