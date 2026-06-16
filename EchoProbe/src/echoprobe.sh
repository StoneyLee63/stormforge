#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

usage() {
    echo "Usage: ./echoprobe.sh [options]"
    echo ""
    echo "Options:"
    echo " --help  Show this help message and exit"
    echo ""
    echo "Examples:"
    echo " ./echoprobe.sh --help"
    echo " ./echoprobe.sh"
}

log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*"
}

error() {
    log "ERROR" "$@" >&2
    exit 1
}

run() {
    log "INFO" "EchoProbe starting..."
    # TODO: implement core logic here
}

main() {
    case "${1:-}" in
    --help|-h)
	usage
	exit 0
	;;
    "")
	run
	;;
    *)
	error "Unknown argument: $1"
	;;
    esac
}

main "$@"
