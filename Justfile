# Run ansible-lint and syntax check
check:
    ansible-lint provision.yml
    ansible-playbook provision.yml --syntax-check

# Run the provisioning playbook
provision:
    ansible-playbook --ask-become-pass provision.yml
