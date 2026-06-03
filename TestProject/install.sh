    #!/usr/bin/env bash

    set -euo pipefail

    INSTALL_DIR="$HOME/.local/bin"
    SCRIPT="testproject.sh"
    SOURCE_DIR="$(cd "$(dirname "$0")" && pwd)/src"

    echo "[*] Installing TestProject..."

    mkdir -p "$INSTALL_DIR"
    cp "$SOURCE_DIR/$SCRIPT" "$INSTALL_DIR/$SCRIPT"
    chmod +x "$INSTALL_DIR/$SCRIPT"

    echo "[+] Installed to $INSTALL_DIR/$SCRIPT"
    echo "[!] Make sure $INSTALL_DIR is in your PATH"
