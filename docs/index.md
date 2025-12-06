# Homelab Overview

Welcome to the documentation for my homelab.

This site is organized to give a clear view of the environment, the machines that power it, and the services that run on top. Use this page as your starting point and jump off into the deeper sections as needed.

---

## Goals of This Homelab!

- Centralized media, services, and tooling
- A safe place to learn, test, and break things
- Practical experience with Linux, Proxmox, networking, and automation
- A documented setup that can be restored or rebuilt when something goes wrong

---

## High-Level Architecture

At a high level, the homelab consists of:

- **Infrastructure**
  - Network (router, switches, VLANs, firewall rules)
  - DNS and name resolution
  - Storage (ZFS, datasets, shares)
  - Hypervisors (Proxmox nodes and virtualization layer)

- **Servers**
  - Physical hosts
  - Proxmox nodes
  - Key VMs and containers

- **Services**
  - Media (e.g. Jellyfin)
  - Remote access (VPN, Cloudflare Tunnel / Zero Trust)
  - Developer tools (e.g. code-server)
  - Automation and scheduled jobs

- **Guides & Procedures**
  - Step-by-step setup guides
  - Troubleshooting notes
  - Repeatable procedures (how to add a VM, how to restore a backup, etc.)

---

## Infrastructure at a Glance

This section is documented in more detail under **Infrastructure**, but in summary:

- **Network**
  - Core LAN and any lab VLANs
  - Router / firewall
  - DNS (Pi-hole + Unbound or other resolvers)

- **Storage**
  - Main storage pool(s)
  - Media datasets / shares
  - Backup locations and strategy

- **Virtualization**
  - Proxmox nodes
  - How VMs and containers are generally laid out

➡️ See: **Infrastructure** section for details.

---

## Servers at a Glance

This section lists the main machines in the lab and what they are responsible for.

Examples (adjust to match your actual hosts):

- **Core Proxmox Node 1** – Primary hypervisor for most VMs
- **Core Proxmox Node 2** – Secondary / backup node
- **Storage / NAS** – Holds main datasets and shares
- **Utility / Toolbox VM(s)** – For dev tools, scripts, and experiments

Each server has (or will have) its own page under **Servers** describing:

- Role / purpose
- Hardware specs
- Important VMs/containers
- Backup and restore notes
- Access details

➡️ See: **Servers** section for details.

---

## Services at a Glance

Key services running in the homelab include:

- **Media**
  - Jellyfin and related components

- **Access**
  - VPN for remote access
  - Cloudflare Tunnel / Zero Trust for secure external access

- **Developer & Utility**
  - code-server and other tooling
  - Any utility dashboards or management interfaces

- **Automation**
  - Scheduled jobs
  - Sync / failover scripts
  - Any “cascade” or failover logic

Each service has (or will have) its own page under **Services** explaining:

- What it does
- How it’s deployed (VM, container, stack)
- Configuration notes
- How to troubleshoot or rebuild it

➡️ See: **Services** section for details.

---

## Documentation Layout

This documentation is organized into the following main sections:

- **Overview** – This page. High-level summary and orientation.
- **Infrastructure** – Network, DNS, storage, hypervisors, and core platform.
- **Servers** – Individual physical hosts and important VMs.
- **Services** – Applications and services running in the lab.
- **Guides** – Setup guides, how-tos, and troubleshooting procedures.
- **Operations** (optional) – Monitoring, backup routines, failover, and maintenance.
- **Reference / Case Files** – Notes, experiments, and less formal material.

As new systems are added or old ones are retired, this overview should be updated to reflect the current state of the homelab.

---
_Last updated: TODO-SET-DATE_
