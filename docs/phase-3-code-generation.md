# StormForge — Phase 3: Code Generation

**Date:** 2026-06-03  
**Phase:** 3 — Heredocs, Name Translation & Script Generation  
**Status:** Complete

---

## Objectives

- Generate a working starter script in `src/` automatically
- Generate files from within Bash
- Write multi-line content with a heredoc
- Transform a project name into a script filename
- Make the generated script executable

---

## What Was Built

Up until Phase 3, StormForge built structure — folders, README, clean layout. Useful, but static. Phase 3 is where it became a generator.

---

## The Name Translator

```bash
local script_name
script_name=$(echo "$project_name" | tr '[:upper:]' '[:lower:]')
```

Converts any input — `EchoProbe`, `TestTool`, `STORMTEST` — into a consistent lowercase filename. This isn't cosmetic. It prevents casing inconsistencies downstream and makes every generated file predictable regardless of how the input was typed.

---

## The Generator Function

```bash
generate_main_script() {
  local project_name="$1"
  local script_name
  script_name=$(echo "$project_name" | tr '[:upper:]' '[:lower:]')

  cat <<EOF > "$project_name/src/${script_name}.sh"
#!/usr/bin/env bash
set -euo pipefail

echo "[*] ${project_name} starting..."
EOF

  chmod +x "$project_name/src/${script_name}.sh"
}
```

`cat <<EOF` injects a complete, formatted Bash file into `src/` in a single operation. No temp files, no manual writing — the script is born with strict mode and an entry point already in place.

`chmod +x` makes it executable immediately at creation time.

---

## The Connection That Made It Work

The function existed. It was solid. But it wasn't doing anything.

Functions don't matter unless they're part of the flow.

Adding this single line inside the `create)` block was the switch:

```bash
generate_main_script "$project_name"
```

That one connection turned StormForge from a tool that makes folders into a system that builds working projects.

---

## Full Creation Flow (Updated)

```
validate input
  → check existence
    → create structure
      → initialize README
        → generate starter script
          → confirm
```

---

## Live Test

```bash
./stormforge.sh create EchoProbe
```

Output:
```
Project 'EchoProbe' created successfully.
```

Structure generated:
```
EchoProbe/
├── src/
│   └── echoprobe.sh
├── docs/
├── tests/
├── logs/
└── README.md
```

Ran the generated script:
```bash
bash EchoProbe/src/echoprobe.sh
# [*] EchoProbe starting...
```

---

## Key Takeaways

- Heredocs (`cat <<EOF`) are the correct pattern for writing multi-line content from within Bash — clean, readable, no escaping hell
- Input transformation (`tr`) is infrastructure, not formatting — it makes the system predictable at every downstream step
- Functions are inert until connected — building something and wiring it in are two different acts
- `chmod +x` at generation time means the output is immediately usable, not waiting on manual setup
- The goal shifted: not writing scripts — building something that writes scripts

---

## What This Demonstrates

- StormForge now generates functional code, not just structure
- Every project it creates comes with a working entry point
- The architecture scales — `generate_main_script` can be extended to generate tests, configs, or any file type
- Input → transform → generate → execute is a full pipeline, not a collection of commands

---

## One-Line Takeaway

Phase 3 is where I stopped writing Bash scripts and started building a system that creates them.
