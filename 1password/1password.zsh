# 1PASSWORD SSH AGENT
# Use 1Password SSH Agent instead of system ssh-agent
# This ensures SSH operations (including git commit signing) use 1Password managed keys

if [[ "$OSTYPE" == darwin* ]]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi