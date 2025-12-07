# Group Policy Framework

This document outlines the Group Policy strategy for the LodgeLab AD environment.

---

## Core GPO Principles

- **Least privilege first**
- **Separate workstation and server policies**
- **Layered, modular GPO design**
- **Document every change**

---

## Recommended GPO Categories

### 1. Baseline Security
- Password policy  
- Account lockout  
- Audit policy  
- Screen timeout  
- Disable guest accounts  

### 2. Workstation Policies
- Disable USB mass storage  
- Configure Windows Update behavior  
- Firewall policy  
- RDP restrictions  

### 3. Server Policies
- Harden RDP  
- Restrict PowerShell execution  
- Disable unnecessary services  
- Configure event logging  

### 4. User Experience Policies
- Map network drives  
- Desktop shortcuts  
- Default browser settings  
- Login banner  

---

## GPO Processing Order

1. **Local**
2. **Site**
3. **Domain**
4. **OU** (deepest OU wins)

---

## Testing GPOs

Use:

```powershell
gpupdate /force
gpresult /r
gpresult /h gp-report.html

A joined Windows 10/11 client VM is recommended for validation.

Next Steps

Define baseline GPO settings

Build workstation and server policies

Attach GPOs to appropriate OUs

---

# ✅ **4. active-directory/dns.md**

```markdown
# Active Directory–Integrated DNS

LodgeLab uses DNS integrated directly into Active Directory.  
This provides fast replication, automatic zone management, and secure updates.

---

## Key Zones

After domain creation, two critical zones were generated:

- `thelorgelab.local`
- `_msdcs.thelorgelab.local`

Both are **AD-integrated** and replicate via SYSVOL/DFSR.

---

## DNS Server Checks

Open **DNS Manager** and confirm:

- Forward lookup zone exists  
- SRV records created  
- Global Catalog records present  
- Host (A) records for DC created  

---

## Essential DNS Records

Look inside:  
`Forward Lookup Zones → thelodgelab.local`

You should see:

- **(A)** DC-LAB → 192.168.199.210  
- **_ldap._tcp.dc._msdcs** SRV record  
- **_kerberos._tcp.dc._msdcs** SRV record  

These verify:
- Kerberos is operational  
- LDAP is reachable  
- The DC is advertising correctly  

---

## DNS Testing

```cmd
nslookup thelodgelab.local
nslookup DC-LAB
dcdiag /test:dns
Next Steps

Add additional DCs (optional)

Configure conditional forwarders

Harden DNS security with DNSSEC (optional)

---

# ✅ **5. active-directory/health.md**

```markdown
# Active Directory Health & Tools

This document provides diagnostic tools and health checks for maintaining the LodgeLab domain.

---

## Core Health Tools

### 1. dcdiag

Run:

```cmd
dcdiag
Validates:

DNS

SYSVOL

Replication

Services

Authentication paths

2. repadmin
repadmin /replsummary
repadmin /showrepl

Useful once you add a second Domain Controller.

3. SYSVOL Status
net share


Verify:

SYSVOL
NETLOGON


Both must appear for a healthy DC.

Common Warnings (Expected on New DCs)

LDAP signing not set

Channel binding token warning

NTP source not authoritative

DNS delegation warning

Single-DC replication warnings

These are normal for a lab and can be addressed later.

When to Fix Warnings

Fix warnings when:

Deploying a second Domain Controller

Preparing for production hybrid use

Hardening security

Implementing PKI

Next Steps

Add 2nd DC (optional)

Build Certificate Authority

Implement Group Policy Baselines


---

# 🟦 Done, Agent.

Your **Active Directory documentation folder is now fully scaffolded**, clean, professional, and ready for deeper work as your lab grows.

If you'd like, I can also generate:

- **A full AD topology diagram (PNG/SVG)**
- **A printable PDF version of your DC Build Guide**
- **A Case File–style redacted FBI-themed AD overview (Twin Peaks aesthetic)**

Just say the word.
