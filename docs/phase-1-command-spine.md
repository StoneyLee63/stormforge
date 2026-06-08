# StormForge — Phase 1: Command Spine

**Date:** 2026-06-03  
**Phase:** 1 — Core Argument Handling & Command Routing  
**Status:** Complete

---

## Objectives

- Implement positional arguments
- Apply default-safe variable assignment
- Build command routing with `case`

---

## Steps

Navigated to the project and opened the main script:

```bash
cd ~/projects/flagships/stormforge
nano stormforge.sh
```

---

## What Was Built

### Strict Mode

```bash
set -euo pipefail
IFS=$'\n\t'
```

- `set -e` — exit immediately on error
- `set -u` — treat unset variables as errors
- `set -o pipefail` — catch failures inside pipes, not just the last command
- `IFS` adjusted to prevent word-splitting on spaces in input

### Usage Function

```bash
usage() {
  echo "Usage: stormforge <command> [project-name]"
  echo ""
  echo "Commands:"
  echo "  create <name>   Create a new project"
  echo "  help            Show this message"
}
```

### Positional Arguments with Default-Safe Guards

```bash
COMMAND="${1:-}"
PROJECT="${2:-}"
```

- `${1:-}` returns an empty string instead of crashing when no argument is passed
- Prevents unbound variable errors under `set -u`

### Command Router

```bash
case "$COMMAND" in
  create)
    if [[ -z "$PROJECT" ]]; then
      echo "Error: project name required"
      usage
      exit 1
    fi
    echo "Creating project: $PROJECT"
    ;;
  help|"")
    usage
    ;;
  *)
    echo "Unknown command: $COMMAND"
    usage
    exit 1
    ;;
esac
```

### Entry Point

```bash
main() {
  # routing logic lives here
}

main "$@"
```

All arguments passed through `"$@"` to preserve spacing and quoting.

---

## Test Coverage

| Input | Expected Result | Result |
|---|---|---|
| No input | Show usage | ✅ |
| `help` | Show usage | ✅ |
| `create` (no name) | Error + usage | ✅ |
| `create stormtest` | Create project | ✅ |
| `unknown` | Unknown command + usage | ✅ |

---

## Key Takeaways

- `set -euo pipefail` is the standard safety header for production Bash — it turns a loose script into a disciplined one
- `${var:-}` is the correct pattern for optional arguments under strict mode — never skip it
- `case` is cleaner than chained `if/elif` for command routing — reads like a menu, scales like a switch
- `main "$@"` is the correct pattern — never call logic at the top level of a script
- `exit 1` on error states is a contract — it tells the caller something went wrong

---

## What This Demonstrates

- StormForge now has a real command interface, not just a placeholder script
- Input validation happens before any logic runs
- The architecture is modular — `main()` routes, functions execute
- Error paths are as intentional as success paths

---

## Current Script State

StormForge correctly receives input, validates it, and routes to the right logic. No features yet — but the spine is solid. Everything from Phase 2 forward plugs into this structure.
