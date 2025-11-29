# Infrastructure Overview

The infrastructure layer forms the foundation of the homelab. It includes the network, DNS, storage, virtualization stack, and all underlying systems that support servers, services, and automation. This section documents how the environment is structured, how core components operate, and what must be restored first when issues arise.

---

## Purpose of This Section

This section exists to answer questions such as:

- **How is the homelab physically and logically structured?**
- **Where do DNS, routing, and VLANs live?**
- **How is storage arranged and protected?**
- **What does the high-level network look like?**
- **What components are foundational for recovery or troubleshooting?**

It provides the technical backbone for the entire environment — a clear reference for configuration, troubleshooting, and future expansion.

---

## What the Infrastructure Covers

Infrastructure includes:

- Physical and virtual networks  
- DNS and name resolution  
- Storage systems and ZFS  
- Proxmox hypervisors and virtualization  
- Supporting operational tools  

Each subsection goes deeper into the technical design of the homelab.

---

## Network

The network defines how devices communicate and how traffic is secured.

Documented here:

- **Network Diagram** – Logical layout of routers, switches, and VLANs  
- **Network Baseline** – IP schema, routing, firewall concepts  

➡️ See the **Network** subsection for details.

---

## DNS

Reliable name resolution supports internal services, certificates, and automation.

This section covers:

- Pi-hole + Unbound  
- DNS filtering  
- Local domain handling  
- Upstream resolver behavior  

➡️ See **DNS** for configuration and troubleshooting.

---

## Storage

Storage underpins media, VMs, backups, and persistent data.

Topics include:

- Dataset layout  
- Media directories  
- NFS/SMB (if applicable)  
- Integration with Proxmox  

➡️ See **Storage** for full details.

---

## ZFS

ZFS provides data integrity, checksumming, snapshots, and replication.

Covered here:

- Pool layout  
- Dataset structure  
- Scrub scheduling  
- Snapshot strategy  
- Replication strategies  

➡️ See **ZFS** for operational details.

---

## Virtualization Layer

The Proxmox hypervisors host the majority of the homelab workloads.

This section will cover:

- Node responsibilities  
- VM layout  
- Container layout  
- Backup/restore workflows  
- Migration or failover considerations  

---

_Last updated: TODO-SET-DATE_
