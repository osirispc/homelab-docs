# LodgeLab OU & User Structure

This document defines the recommended Organizational Unit (OU) hierarchy and user account structure for the LodgeLab domain.

---

## OU Design Philosophy

The OU layout follows three core principles:

1. **Separation of roles** — servers, workstations, and user objects stay isolated  
2. **Delegation clarity** — permissions are applied to specific OUs  
3. **GPO targeting** — policies are applied cleanly without overreach  

---

## Recommended OU Layout

thelorgelab.local
│
├── _Admin
│ ├── Admin Accounts
│ └── Service Accounts
│
├── Users
│ ├── IT
│ ├── Staff
│ └── Testing
│
├── Computers
│ ├── Workstations
│ └── Laptops
│
├── Servers
│ ├── Core Infrastructure
│ └── Application Servers
│
└── Groups
├── Security Groups
├── Distribution Groups
└── Role-Based Access Groups

---

## User Types

- **Standard Users**: Normal employees or household users  
- **Privileged Admins**: Domain Admins, Server Admins, helpdesk roles  
- **Service Accounts**: For applications, automation, and scheduled tasks  
- **Test Users**: For lab experiments and GPO validation  

---

## Next Steps

- Create OUs in **Active Directory Users and Computers**  
- Move existing computer objects into correct OUs  
- Apply GPOs to the correct OU targets  
