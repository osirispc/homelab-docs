Alright. Let’s write it into your case file so Future-Osiris can pull it off the shelf and repeat it without a séance.

Below is a ready-to-paste Markdown page **plus** the exact steps to place it and wire it into the sidebar.

---

## Step 1) Create the new doc page

**Machine:** `pacard-sawmill`
**Path:**
`/home/osirisortiz/projects/homelab-docs/docs/infra/mkdocs-docker-instant-reload.md`

Run:

```bash
nano /home/osirisortiz/projects/homelab-docs/docs/infra/mkdocs-docker-instant-reload.md
```

Paste this whole page:

````markdown
# MkDocs in Docker: Instant Reload Fix (Polling Watcher)

When MkDocs runs inside a Docker container, it may not detect file changes from the host.
Symptoms look like this:

- You edit a `.md` file on the host
- Browser shows old content
- **Only updates after you restart the container**

This happens because Docker bind mounts sometimes **do not forward file-change events**
(inotify/watchdog) into the container. So MkDocs never gets the “something changed” signal.

The cure: **force polling** so MkDocs checks the filesystem on an interval.

---

## ✅ The Golden Fix

Add polling env vars and an explicit serve command to your Docker Compose service.

### Example `docker-compose.yml`

```yml
services:
  mkdocs:
    image: squidfunk/mkdocs-material:9.5.31
    container_name: mkdocs-dev
    ports:
      - "8181:8000"
    volumes:
      - /FULL/PATH/TO/YOUR/REPO:/docs
    environment:
      - WATCHFILES_FORCE_POLLING=true
      - WATCHFILES_POLL_DELAY_MS=300
    command: serve -a 0.0.0.0:8000 --livereload -w docs -w mkdocs.yml
    restart: unless-stopped
````

### What each line is doing

* `WATCHFILES_FORCE_POLLING=true`
  Forces MkDocs’ watcher to **poll for changes** instead of waiting for inotify events.

* `WATCHFILES_POLL_DELAY_MS=300`
  How often it checks for changes (300ms feels instant without burning CPU).

* `command: serve ... --livereload -w docs -w mkdocs.yml`
  Makes the container run the dev server with:

  * livereload enabled
  * explicit watch targets so it always rebuilds on edits.

* `volumes: /repo:/docs`
  Always mount the **whole repo folder**, not individual files.
  Single-file mounts can “freeze” because editors swap temp files/inodes.

---

## How to Verify It's Working

1. Start the container:

   ```bash
   docker compose up -d --force-recreate
   docker logs -f mkdocs-dev
   ```

2. You should see:

   ```
   Watching paths for changes: 'docs', 'mkdocs.yml'
   Serving on http://0.0.0.0:8000/
   ```

3. Edit any markdown file under `docs/` and save.

4. Logs should immediately show:

   ```
   Building documentation...
   Documentation built in ...
   ```

If you see that without restarting the container, you're back on the good road.

---

## Notes

* MkDocs will warn about `0.0.0.0` being “production-like.”
  In Docker that’s normal — it allows port mapping to your host.

* If your repo lives on a network share (NFS/CIFS),
  increase polling delay (ex: 500–1000ms).

---

## Quick Reference Snippet

```yml
environment:
  - WATCHFILES_FORCE_POLLING=true
  - WATCHFILES_POLL_DELAY_MS=300
command: serve -a 0.0.0.0:8000 --livereload -w docs -w mkdocs.yml
volumes:
  - /FULL/PATH/TO/REPO:/docs
```

That’s the whole spell.

````

Save and exit:
- **Ctrl+O**, Enter
- **Ctrl+X**

---

## Step 2) Wire it into the sidebar (mkdocs.yml)

**File:**  
`/home/osirisortiz/projects/homelab-docs/mkdocs.yml`

Open it:

```bash
nano /home/osirisortiz/projects/homelab-docs/mkdocs.yml
````

Find your `nav:` section. Add this entry wherever your Infra/docker docs live.

Example:

```yml
nav:
  - Home: index.md
  - Infra:
      - Overview: infra/index.md
      - MkDocs Docker Instant Reload Fix: infra/mkdocs-docker-instant-reload.md
```

If you already have an Infra section with other pages, just drop the new line under it.

Save + exit.

---

## Step 3) Confirm it shows up

If your homelab docs dev container is running on port **8002**, refresh:

`http://192.168.199.177:8002/`

You should see a new sidebar item:
**Infra → MkDocs Docker Instant Reload Fix**

---

If you paste your current `nav:` block here, I’ll tell you the *exact* spot to insert the line so it matches your structure perfectly.
