#!/usr/bin/env bash
# Bootstrap script for GitHub Codespaces
# This script is specifically designed to run in GitHub Codespaces environments only.
# It installs Ansible and runs the Codespace-specific provisioning playbook that
# only configures dotfiles without installing packages or requiring sudo access.
set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_info() {
    echo -e "${YELLOW}[INFO]${NC} $1"
}

# Check if running in GitHub Codespaces
if [ -z "${CODESPACES:-}" ] || [ "${CODESPACES}" != "true" ]; then
    print_error "This script is designed to run only in GitHub Codespaces."
    print_error "Please use 'ansible-playbook provision.yml' for local provisioning."
    exit 1
fi

print_info "Running in GitHub Codespaces environment"

# Check if running on Ubuntu-based OS
if [ ! -f /etc/os-release ]; then
    print_error "Cannot detect OS. /etc/os-release not found."
    exit 1
fi

# Source the os-release file
. /etc/os-release

# Check if it's Ubuntu or Ubuntu-based
if [[ ! "$ID" =~ ^(ubuntu|debian)$ ]] && [[ ! "$ID_LIKE" =~ ubuntu ]]; then
    print_error "This script only supports Ubuntu-based operating systems."
    print_error "Detected OS: $NAME ($ID)"
    exit 1
fi

print_info "Detected Ubuntu-based OS: $NAME"

# Update package list
print_info "Updating package list..."
sudo apt-get update -qq

# Install Ansible
print_info "Installing Ansible..."
if ! command -v ansible-playbook &> /dev/null; then
    sudo apt-get install -y ansible
    print_success "Ansible installed successfully"
else
    print_info "Ansible is already installed"
fi

# Verify Ansible installation
ansible_version=$(ansible-playbook --version | head -n1)
print_info "Using $ansible_version"

# Install Ansible collection dependencies
print_info "Installing Ansible collection dependencies..."
ansible-galaxy collection install -r requirements.yml
print_success "Ansible collections installed"

# Run the Codespace-specific provisioning playbook
print_info "Running Codespace provisioning playbook..."
ansible-playbook provision-codespace.yml

print_success "Codespace bootstrap complete!"
print_info "Note: Only configuration tasks were run. No packages were installed."