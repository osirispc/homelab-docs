# Twin Peaks VS Code Theme & Icon Pack (VSIX)

## Overview
This guide documents the full process of creating, packaging, and publishing the **Twin Peaks VS Code Theme Pack**, including the Red Room color theme, Lodge Icon Pack, and a VSIX installer so it can be used across machines or shared publicly.

This extension includes:
- **Twin Peaks: Red Room** (dark editor theme)
- **Lodge Icon Pack** (custom VS Code file/folder icons)
- **Complete VSIX package**
- **GitHub repository setup**
- **Optional marketplace publishing**

---

## Install the Twin Peaks VSIX

### **1. Upload or place the VSIX file**
Place the file:

```
twinpeaks-theme-pack-1.0.0.vsix
```

somewhere easy to access, such as:

```
~/projects/vscode-twinpeaks/
```

---

### **2. Install in VS Code (Desktop)**
Open VS Code → Extensions sidebar →  
Click **⋮ (three dots)** → **Install from VSIX…** → select the file.

---

### **3. Install in code-server**
Use:

```bash
code-server --install-extension twinpeaks-theme-pack-1.0.0.vsix
```

Reload the browser tab.

---

### **4. Activate the theme & icons**

Press **F1** → select:

- **Preferences: Color Theme → Twin Peaks: Red Room**
- **Preferences: File Icon Theme → Twin Peaks: Lodge Icons**

---

## Repository Setup (GitHub)

### 1. Install GitHub CLI

```bash
sudo apt install gh -y
```

---

### 2. Authenticate GitHub CLI

```bash
gh auth login
```

Choose:
- GitHub.com  
- HTTPS  
- Yes to git credential login  
- Authenticate with browser  

---

### 3. Create the repository

From inside the project folder:

```bash
cd ~/projects/vscode-twinpeaks
gh repo create vscode-twinpeaks --public --source=. --remote=origin --push
```

Your repo is now live on GitHub.

---

## MkDocs Navigation Entry

Add this to `mkdocs.yml` under your desired section:

```yaml
  - Twin Peaks VS Code Theme Pack: vscode-twinpeaks.md
```

---

## Changelog

### **v1.0.0 – Initial Release**
- Added Red Room VS Code color theme  
- Added Lodge Icon Pack (folders + files)  
- Packaged full extension as VSIX  
- Set up GitHub repo structure  
- Documented installation and usage  

---

*Prepared in cooperation with Agent Cooper. The owls are watching.*