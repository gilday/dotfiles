# Install Ansible collection dependencies
install:
    ansible-galaxy collection install -r requirements.yml

# Run ansible-lint and syntax check
check:
    ansible-lint --strict provision.yml
    ansible-playbook provision.yml --syntax-check

# Run the provisioning playbook
provision: install
    ansible-playbook --ask-become-pass provision.yml
