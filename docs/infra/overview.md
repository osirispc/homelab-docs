# Infrastructure Overview

This section documents the core foundation of the homelab — the systems that support all servers, services, workloads, and automation. These components form the underlying platform on which everything else runs.

The infrastructure layer includes:

- Physical and virtual networking
- DNS and name resolution
- Storage architecture and file systems
- ZFS datasets, snapshots, and replication
- Proxmox hypervisors and virtualization
- Any supporting tools used to maintain or monitor the environment

Each subsection of this area goes deeper into the technical details behind how the homelab is designed and how it operates.

---

## Network

The network forms the spine of the environment. It determines how devices communicate, how traffic flows, and how security boundaries are enforced.

Covered in detail:

- **Network Diagram** – Logical layout of switches, routers, VLANs, and links  
- **Network Baseline** – IP schema, routing behavior, firewall considerations  

➡️ See the **Network** subsection for details.

---

## DNS

Reliable name resolution is critical for access, automation, certificate validation, and internal service discovery.

Documented here:

- **Pi-hole + Unbound recursive DNS**
- DNS filtering policy
- Local domain handling
- Upstream resolvers

➡️ See **DNS** for configuration and troubleshooting.

---

## Storage

Storage provides the foundation for media, VMs, backups, and shared data.

Topics include:

- Storage layout and datasets  
- Media directories  
- NFS/SMB (if used)  
- Integration with Proxmox  

➡️ See **Storage** for the full breakdown.

---

## ZFS

ZFS is used for reliability, integrity, and snapshot-based recovery.

This section covers:

- Pool layout  
- Dataset structure  
- Scrubs and maintenance  
- Snapshots  
- Replication between nodes  

➡️ See **ZFS** for commands, schedules, and operational notes.

---

## Virtualization Layer

The Proxmox hypervisor stack runs most of the homelab workloads.

Recommended content for this section:

- Node responsibilities  
- VM layout  
- Container layout  
- Backup strategy (Proxmox Backup Server or other)  
- Live migration or failover considerations  

*(Note: This section may be expanded into its own page later.)*

---

## Purpose of This Section

Infrastructure exists to answer questions like:

- “How is the homelab physically and logically structured?”  
- “Where does DNS live, and how is it configured?”  
- “How is storage arranged, protected, and backed up?”  
- “What does the network look like at a high level?”  
- “What components must be restored first in a disaster?”  

This is the deepest layer of the homelab and the most important for stability.  
Changes here should be made intentionally and documented immediately.

---

_Last updated: TODO-SET-DATE_
