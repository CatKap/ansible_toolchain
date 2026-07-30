# ANSIBLE Playbooks & Roles

Welcome to the **Ansible** project repository. This collection contains reusable Ansible playbooks, roles, and example configurations for automating common tasks such as:

- Setting up secure FTP servers (`ansible-pure-ftpd`)
- Deploying Docker and containerized services
- Managing PostgreSQL instances
- Configuring Nginx with JWT authentication
- Provisioning Kubernetes and cloud resources
- Miscellaneous task automation scripts

## Directory Structure

```
├── ansible-pure-ftpd/                # FTPS server role and playbooks
├── kuber/                            # Kubernetes-related playbooks
├── modules/                          # Custom Ansible modules
├── roles/                            # Reusable Ansible roles
│   ├── nginx-auth-jwt/               # Nginx + JWT authentication role
│   └── ...                           # Additional roles
├── playbook-*.yaml                   # Individual playbooks (e.g., postgres-check)
├── tasks/                            # Task files used by playbooks
├── collections/                      # Ansible Collections (if any)
├── scripts/                          # Helper scripts
├── inventory.yml                     # Inventory file for target hosts
└── example-repo-role.yaml            # Example role definition
```

## Prerequisites

- **Ansible** >= 2.14
- **Python** >= 3.9 on control node
- Access to target hosts via SSH (or other supported connection methods)
- Required Python packages listed in `requirements.txt` (if present)

## Getting Started

1. **Clone the repository**
   ```bash
   git clone <repo-url>
   cd ansiblyat
   ```

2. **Set up inventory**
   Edit `inventory.yml` to include your target hosts and groups.

3. **Install dependencies** (if any)
   ```bash
   pip install -r requirements.txt   # optional
   ```

4. **Run a playbook**
   ```bash
   ansible-playbook -i inventory.yml playbook-03-postgres-check.yaml
   ```

   Adjust the playbook name and variables as needed for your use case.

## Role Usage

Roles are located under the `roles/` directory. To use a role:

```yaml
- hosts: all
  roles:
    - role: nginx-auth-jwt
      vars:
        jwt_secret: "your_secret_key"
```

Refer to each role’s README inside its folder for specific variables and parameters.

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feat/feature-name`)
3. Commit your changes
4. Submit a Pull Request

Ensure that:
- Code follows the existing Ansible formatting conventions
- Tests (if any) pass
- Documentation is updated for new variables or options

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## Contact

For questions or support, open an issue or reach out to the maintainer:

- **Ilya Dutov** – <your.email@example.com>

---

*Happy automating!*