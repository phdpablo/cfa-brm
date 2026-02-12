# Docker Scripts for RStudio Environment

Three simple scripts to manage your containerized RStudio workflow:

## `start.sh` — Resume or Create Container

Starts (or resumes if paused) the RStudio container and opens it in your browser.

```bash
./start.sh
```

**Behavior:**
- If container exists but is paused → resumes it (preserves all data)
- If container doesn't exist → creates new one from image
- Automatically finds available IP (handles multiple instances)
- Opens RStudio in default browser at `http://127.0.0.x:8787`

## `stop.sh` — Pause Container (Preserve Data)

Pauses the container. All files, caches, and rendered outputs remain inside.

```bash
./stop.sh
```

**Behavior:**
- Container is paused (not deleted)
- All data persists
- Next `./start.sh` resumes exactly where you left off
- Low overhead, perfect for daily workflows

## `clean.sh` — Delete Container (Start Fresh)

Completely removes the container and all data inside. Use before extracting final outputs.

```bash
./clean.sh
```

**Behavior:**
- Asks for confirmation
- Deletes container and networks
- Next `./start.sh` creates fresh container from image
- Use when you want to reset to clean state

## `extract.sh` — Backup Outputs to Host

Copies rendered files from container to host before cleaning.

```bash
./extract.sh
```

**Copies:**
- `_output/` (rendered documents)
- `_files/` (generated assets)
- `*.html` files

Saves to `./extracted_output/`

---

## Typical Workflow

### Session-to-session (recommended for dev)
```bash
./start.sh          # Resume work
# ... edit, render, work in RStudio ...
./stop.sh           # Pause (data stays)

# Later:
./start.sh          # Everything is still there
```

### Clean slate (when updating Dockerfile or resetting)
```bash
./extract.sh        # Backup outputs to host
./clean.sh          # Remove container
./start.sh          # Fresh container from updated image
```

### For reproducibility
- `stop` / `start` preserves your session
- `clean` forces rebuild from image (guarantees reproducibility)
- Always `extract` before `clean` if you need outputs

---

## Data Persistence

**What persists between stop/start:**
- Rendered HTML files (in `/home/rstudio/project/`)
- R caches and renv packages (built into image)
- Any files created in container

**What doesn't persist after `clean.sh`:**
- Anything in the container (everything is deleted)
- Outputs must be extracted with `./extract.sh` first

**What never persists (ephemeral):**
- RStudio session state (temporary, resets on start)
- Console history (unless you save explicitly)

---

## Notes

- All scripts use `docker compose` with project name isolation
- Multiple containers can run simultaneously on different IPs
- Change file permissions: `chmod +x *.sh` if needed
