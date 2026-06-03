# StormForge — Phase 0: Project Initialization

**Date:** 2026-06-03  
**Phase:** 0 — Workspace Setup & Project Skeleton  
**Status:** Complete

---

## Objectives

- Create the project skeleton
- Define the folder structure and its purpose
- Install packages that support Bash development
- Verify the workspace is real, clean, and under version control

---

## Steps 1–3: Directory Structure & File Creation

Created the flagships directory and navigated into it:

```bash
mkdir -p ~/projects/flagships
cd ~/projects/flagships
```

Created the StormForge project folder and entered it:

```bash
mkdir stormforge
cd stormforge
pwd
# /home/<user>/projects/flagships/stormforge
```

Created the full project skeleton — subfolders and root files:

```bash
mkdir -p templates lib docs tests examples
touch stormforge.sh README.md .gitignore
chmod +x stormforge.sh
```

### Folder Structure

| Folder | Purpose |
|---|---|
| `templates/` | Reusable file templates |
| `lib/` | Helper logic for when StormForge gets modularized |
| `docs/` | Design notes and architecture documentation |
| `tests/` | Smoke tests and validation scripts |
| `examples/` | Generated examples and usage samples |

### Root Files

| File | Purpose |
|---|---|
| `stormforge.sh` | Main entry point script |
| `README.md` | Project documentation |
| `.gitignore` | Git ignore rules |

`chmod +x stormforge.sh` — marks the entry point as executable from the start.

---

## Steps 4–6: Toolchain Installation & Structure Verification

Updated system and installed the core development packages:

```bash
sudo apt update
sudo apt install -y git tree shellcheck
```

| Package | Purpose |
|---|---|
| `git` | Version control |
| `tree` | Visualizes project structure quickly |
| `shellcheck` | Catches Bash mistakes before they become bugs |

Verified the full project structure:

```bash
tree -a
```

Confirmed all subfolders and files present. Then initialized the README:

```bash
nano README.md
```

Marked this as the first of three flagship tools.

---

## Step 7: Git Initialization & Identity Setup

Configured `.gitignore` to exclude logs and temp files. Clean project from day one.

Initialized Git without sudo — ownership matters in your own environment:

```bash
git init
git branch -m main
git config --global init.defaultBranch main
```

Set commit identity tied to GitHub account:

```bash
git config --global user.name "StoneyLee63"
git config --global user.email "191430198+StoneyLee63@users.noreply.github.com"
```

Staged all files and committed:

```bash
git add .
git commit -m "Initialize StormForge project skeleton"
```

---

## Verification

```
branch:       main
working tree: clean
structure:    intact
executable:   stormforge.sh
identity:     committed
```

---

## What Was Learned

- Git tracks identity, not just files — every commit carries a permanent stamp of who made it
- `chmod +x` before the code exists signals intent — this file is the entry point
- `shellcheck` installed at the start means discipline is built into the workflow, not added later
- No sudo on `git init` — own your environment, don't borrow it

---

## Operator Note

No code yet. That's the point.

Phase 0 wasn't about building — it was about claiming the space and setting the rules of operation before anything gets written. StormForge is officially initialized. The structure is in place. The identity is set. Everything from here builds on a clean foundation.
