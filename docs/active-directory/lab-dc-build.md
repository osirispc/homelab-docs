# Building the LodgeLab Domain Controller  
*Windows Server 2019 on Proxmox (Q35 + VirtIO + AD DS)*

---

## Overview

This guide documents the full process of building a Windows Server 2019 Domain Controller inside Proxmox for the **LodgeLab** environment.  
It covers:

- Preparing Proxmox storage for ISOs  
- Fixing QEMU/boot errors  
- Configuring VM hardware for Windows  
- Installing Windows Server using VirtIO drivers  
- Adding network drivers  
- Installing Active Directory Domain Services  
- Promoting the server to a Domain Controller  
- Validating with `dcdiag`

This guide reflects the exact real-time setup performed on **theblacklodge** node.

---

## 1. Preparing ISO Storage on Proxmox

### 1.1 Confirm correct storage path
We discovered that the real ISO directory was:



/mnt/mypool/isos/template/iso/



This contained:

- Windows Server ISO  
- VirtIO driver ISO  

### 1.2 Create or edit Proxmox storage entry  
Navigate:

**Datacenter → Storage → Add → Directory**

Or edit an existing one:



ID: mypool-iso
Directory: /mnt/mypool/isos/template/iso
Content: ISO image
Nodes: theblacklodge
Enable: ☑
Shared: ☐

```

After this, ISOs appeared properly in the VM creation menu.

---

## 2. Creating the Windows Server VM in Proxmox

### 2.1 General
- **Name:** `DC-LAB`
- **VMID:** 700 (your choice)

### 2.2 OS
- Use **Windows Server 2019 ISO**  
- *Do not* use TPM for this lab.

### 2.3 System
- **BIOS:** SeaBIOS  
- **Machine:** `q35`  
- **Display:** Default  
- **Add SCSI Controller:** VirtIO SCSI (single)

### 2.4 Hard Disk
- **Bus:** SCSI  
- **Size:** 80GB  
- **Storage:** mypool  
- **Cache:** none  
- **IO thread:** enabled  
- **Format:** qcow2

### 2.5 CPU & Memory
- **2 cores (host type)**  
- **8GB RAM**

### 2.6 Network
- **Model:** Intel E1000  
- Bridge: `vmbr0`  
- (We later confirmed `vmbr1` did not exist)

### 2.7 Boot order
Make sure:

1. CD-ROM first  
2. Disk second  

---

## 3. Fixing the QEMU Start Error

You encountered:

```

start failed: QEMU exited with code 1
bridge 'vmbr1' does not exist

```

Solution:

Edit `/etc/pve/qemu-server/700.conf`  
Changed:

```

net0: e1000=XX:XX:XX,bridge=vmbr1

```

to:

```

bridge=vmbr0

```

Then the VM booted successfully.

---

## 4. Installing Windows Server

### 4.1 Windows Installer did not detect disk  
Because your VM uses **VirtIO SCSI**, the Windows installer needed additional drivers.

### 4.2 Load SCSI Driver
Click:

**Load Driver → Browse → viostor → 2k19 → amd64**

Select:

- **Red Hat VirtIO SCSI Controller**

After loading, the 80GB disk appeared.

### 4.3 Fixing Windows install error  
You briefly saw:

```

Windows cannot be installed to this disk. This computer's hardware may not support booting to this disk.

```

Solution:

- Delete the partition  
- Recreate New partition  
- Format  
- Proceed  

Windows installed successfully.

---

## 5. Post-Install Fix: Network Driver Missing

After login, Windows showed **No Internet**.

### Fix:
Mount the **VirtIO ISO** again, then:

**Device Manager → Other Devices → PCI Device → Update Driver**

Browse to:

```

NetKVM → 2k19 → amd64

```

Once loaded, network became active and DHCP supplied:

```

192.168.199.210

```

Gateway/DNS verified.

---

## 6. Installing Active Directory Domain Services (AD DS)

### 6.1 Add the Role
Open **Server Manager → Add Roles and Features**

Select:

- **Active Directory Domain Services**
- DNS installs automatically

### 6.2 Promote to Domain Controller
After installation, click:

**Promote this server to a domain controller**

Choose:

- **Add a new forest**
- **Domain name:** `thelorgelab.local` (example used: thelodgelab.local)

No DNS delegation is needed — ignore the warning.

### 6.3 Paths
Use defaults:

```

C:\Windows\NTDS
C:\Windows\SYSVOL

```

### 6.4 Reboot  
Upon reboot, Windows logs in under:

```

thelorgelab\Administrator

````

---

## 7. Validating Domain Controller Health

Run:

```cmd
dcdiag
````

We validated:

* SYSVOL shared
* DNS service registered
* KCC functioning
* Replication tests (only warnings—normal for brand-new single DC)
* Role holders (RID, PDC, Infrastructure) assigned

All critical tests passed.

---

## 8. Current Status

Your LodgeLab Domain Controller is now:

✔ Fully installed
✔ Running AD DS
✔ Running DNS
✔ SYSVOL healthy
✔ Network online
✔ Ready for clients, OUs, GPOs, CA, NPS, file servers, hybrid Azure join, etc.

---

## 9. Next Steps (Phase 2 Options)

Choose your direction when ready:

### **Option A — Build Organizational Units & Users**

* Create the Lodge OU structure
* Create IT accounts, service accounts
* Admin tiering (Tier 0/1/2)

### **Option B — Join a Windows Client to the Domain**

* Build a Windows 10/11 VM
* Join `thelorgelab.local`

### **Option C — Install Certificate Authority (AD CS)**

* Needed for RDP, LDAPS, Wi-Fi authentication, Intune hybrid cert, etc.

### **Option D — Build Group Policies**

* Security baselines
* Drive maps
* Lockdowns
* Login scripts

### **Option E — Hybrid Azure AD**

* AAD Connect
* Sync OUs
* Password hash or seamless SSO
* Prep for Azure AD-only migration

---

## Change Log

| Date       | Change                                                    |
| ---------- | --------------------------------------------------------- |
| 2025-12-07 | Initial documentation created based on live build session |

---

*“Another room in the Lodge opens, Agent. When you’re ready to walk deeper, I’ll be waiting.”*

```

---

If you want, I can also:

✅ Generate a *sidebar nav entry* for MkDocs  
✅ Create additional pages (Phase 2, OU design, Group Policy, etc.)  
✅ Produce a diagram of your AD topology  

Just say the word.
```
