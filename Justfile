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

# Restart the Claude Code signing ssh-agent and reload its key from 1Password
claude-agent-reload:
    launchctl kickstart -k gui/$(id -u)/com.gilday.claude-ssh-agent
    @echo "Unlock 1Password if prompted, then verify:"
    @echo "  SSH_AUTH_SOCK=~/.ssh/claude-agent.sock ssh-add -l"
