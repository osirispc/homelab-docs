# 🌲 **1) How to Start the Dev Environment (Every Time)**

Whenever you want to edit your Homelab Docs, do this:

### ✅ **Step 1 — Go to your project**

```bash
cd ~/projects/homelab-docs
```

### ✅ **Step 2 — Activate your virtual environment**

```bash
source .venv/bin/activate
```

You should see:

```
(.venv)
```

### ✅ **Step 3 — Start MkDocs with live reload (the working mode)**

```bash
export MKDOCS_WATCH=1
mkdocs serve -a 0.0.0.0:8002
```

This gives you:

* Dynamic updates
* Polling mode (solved your code-server issue)
* Instant reload
* Smooth editing

### 🧭 Your site is now live at:

```
http://192.168.199.177:8002/
```

When you’re done working:

### ❌ **Stop the server**

Just press:

```
CTRL + C
```

Done.

---

# 🌲 **2) Add a Page to Your Homelab Docs (so you never forget this setup)**

## **mkdocs-dev-setup.md**

````md
# Homelab Docs – MkDocs Dev Environment Setup

This page explains how to start the development server for the Homelab Docs project.  
Following these steps ensures live reload, correct file watching, and a clean workflow.

---

## 1. Navigate to the Project Directory

```bash
cd ~/projects/homelab-docs
````

---

## 2. Activate the Python Virtual Environment

```bash
source .venv/bin/activate
```

Once activated, your prompt will show:

```
(.venv)
```

---

## 3. Enable Polling Mode (Required for code-server)

```bash
export MKDOCS_WATCH=1
```

Polling mode ensures MkDocs correctly detects file changes when using code-server.

---

## 4. Start the MkDocs Development Server

```bash
mkdocs serve -a 0.0.0.0:8002
```

The site will become available at:

```
http://192.168.199.177:8002/
```

---

## 5. Stopping the Server

Press:

```
CTRL + C
```

---

## Notes

### Watch Setting in `mkdocs.yml`

This project requires a manual watch directive so MkDocs always tracks the correct folder:

```yaml
watch:
  - docs
```

### Why We Use Polling Mode

Because code-server writes files in a way that breaks standard file watchers,
`MKDOCS_WATCH=1` forces MkDocs to use a reliable, polling-based watcher that never misses changes.

---

## That’s it.

You now have a fully working development workflow for Homelab Docs.