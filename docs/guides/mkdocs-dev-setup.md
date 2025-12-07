Ah yes… the *why* behind the ritual. A good instinct. When you understand what each step does, the machinery stops feeling mysterious—and starts feeling like an old friend.

Here is your **complete, clean, copy-paste-ready `.md` file** with clear explanations baked in.

You can paste this directly into your Homelab Docs.

---

````md
# 🌲 Homelab Docs – MkDocs Dev Environment Startup (SOP)

**Purpose:**  
This procedure starts the MkDocs development server for the Homelab Docs project with full live-reload support and reliable file watching while using code-server.

Use this **every time** you want to edit or work on your documentation.

---

## ✅ Step 1 — Open the Project Directory

```bash
cd ~/projects/homelab-docs
````

### What this does:

Moves your terminal into the Homelab Docs project folder so all commands run in the correct location.

---

## ✅ Step 2 — Activate the Python Virtual Environment

```bash
source .venv/bin/activate
```

You should now see:

```
(.venv)
```

### What this does:

This activates your **isolated Python environment**, ensuring:

* MkDocs runs with the correct dependencies
* System Python is never altered
* Package conflicts are avoided

If `(.venv)` does not appear, **stop here and do not continue**.

---

## ✅ Step 3 — Enable Reliable File Watching (Required for code-server)

```bash
export MKDOCS_WATCH=1
```

### What this does:

Forces MkDocs to use **polling mode** instead of standard file watchers.

This is required because:

* code-server writes files in a way that breaks default file watching
* Without this, changes may not reload
* With this, every edit is detected reliably

---

## ✅ Step 4 — Start the MkDocs Development Server

```bash
mkdocs serve -a 0.0.0.0:8002
```

### What this does:

* Starts the live development web server
* Enables automatic page reload on file changes
* Binds the service to **all network interfaces**
* Makes the site accessible from other devices on the network

---

## 🌐 Access the Documentation Site

Open your browser to:

```
http://192.168.199.177:8002/
```

Your site is now live with instant updates.

---

## ❌ Stopping the Server

When you're finished working:

```
CTRL + C
```

### What this does:

* Gracefully stops the MkDocs server
* Frees the network port
* Safely exits the development process

---

## ⚙️ Required Project Setting (One-Time Setup)

Your `mkdocs.yml` **must contain** this entry:

```yaml
watch:
  - docs
```

### What this does:

Ensures MkDocs always monitors the correct documentation directory for changes.

---

## ✅ Summary — The Full Startup Flow

```bash
cd ~/projects/homelab-docs
source .venv/bin/activate
export MKDOCS_WATCH=1
mkdocs serve -a 0.0.0.0:8002
```

---

## Final Note

This workflow guarantees:

* Reliable live reload
* No missed file changes
* Clean Python isolation
* Network-accessible dev site
* Zero guesswork

When this SOP is followed, the system behaves… predictably.

And that’s exactly how we like it.

```

---

