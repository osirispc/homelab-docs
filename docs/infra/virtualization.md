# Virtualization Overview (Proxmox)

The virtualization layer is the core platform on which nearly all homelab workloads run. Proxmox VE provides the hypervisor, clustering, storage integration, snapshots, and management interfaces used to deploy and maintain virtual machines and containers.

This page serves as the high-level reference for how virtualization is structured in the environment.

---

## Goals of the Virtualization Layer

- Centralize compute resources  
- Isolate workloads into VMs and containers  
- Provide simple backup and restore options  
- Enable testing and experimentation safely  
- Support future expansion and additional nodes  

---

## Current Proxmox Nodes

List your nodes here (example):

- **The White Lodge** – Primary hypervisor  
- **The Black Lodge** – Secondary hypervisor, backup target  
- **Pacard Sawmill** – Utility compute / dev workloads  

Each node typically includes:

- CPU, memory, and storage layout  
- Network bridges (e.g., vmbr0, vmbr1)  
- Attached storage pools (ZFS, NFS, or local-lvm)  

---

## Virtual Machines (VMs)

Document key VMs:

- Purpose  
- OS type  
- Disks & storage  
- Backup strategy  
- Dependencies  
- Snapshots (automatic or manual)

Examples:

- **RARR VM** — Media automation  
- **DNS / Pi-hole VM** — DNS core  
- **Utility VM** — Code-server, docker, tooling  

---

## Linux Containers (LXC)

If you use LXC, list:

- Purpose  
- Network mode  
- Backing storage  
- Security considerations  
- Backup configuration  

---

## Storage Integration

Proxmox ties into ZFS and other storage layers.

Document:

- Pools assigned to each node  
- ZFS datasets used for VM disks  
- Any replication schedules  

Examples:

- `mypool/vmdata` → VM disks  
- `mypool/containers` → LXC rootfs  
- ZFS replication → The Black Lodge nightly  

---

## Backups

Document backup behavior:

- Proxmox Backup Server (PBS) or external storage  
- Backup schedules  
- Retention policies  
- How to restore a VM or container  

Examples:

- Daily backups at 2 AM  
- Retention: 7 daily, 4 weekly, 1 monthly  
- Replicated snapshots to secondary node  

---

## Networking in Proxmox

Explain:

- Bridges (vmbr0 / vmbr1)  
- VLANs  
- Trunk ports  
- Network segregation for lab, media, IoT, guest networks  

---

## Failover & Recovery

Document any manual or automatic failover procedures:

- ZFS replication to backup node  
- Restoring a VM on a different node  
- Floating IPs or planned HA  

---

_Last updated: TODO-SET-DATE_
