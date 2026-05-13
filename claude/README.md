# Claude Code

Notes on how Claude Code is set up on my machines, with a focus on
motivation rather than mechanics. For the mechanics, read the module
files themselves (`claude/claude.yml`, `claude-signing/claude-signing.yml`,
`claude/managed-settings.yml.j2`); they're short and well-commented.

## Why agent commit signing exists

My personal SSH key, managed by 1Password, requires Touch ID on every
signing operation. That biometric is exactly the right protection for
"actually me" commits, and I won't relax it. But it breaks any unattended
workflow:

- Overnight automation runs that need to commit progress on their own
- AFK sessions where I've stepped away from the desk for a meeting
- Tasks I expect to span hours of mostly-idle wall time

I used to send those workloads to GitHub Codespaces, where commits get
signed by GitHub's web-flow key on my behalf. That works, but it costs
Codespaces minutes, adds latency, and means my local machine sits idle
while a remote VM does work that's already cheap on my hardware. I'd
rather use local compute and accept the small upfront cost of building
out an identity that can sign without a fingerprint.

## Things I won't trade away

A few constraints fell out immediately and shaped everything else:

- **The personal key stays in 1Password.** Moving it to the filesystem
  undoes 1Password's whole protection model. Off the table.
- **Biometric stays on the personal key.** That's the line between
  "Johnathan committed this" and "something running as Johnathan
  committed this." I'm not willing to blur it.
- **Agent commits should be visibly different from mine.** If a script
  running on my behalf commits something while I'm asleep, the
  `git log --show-signature` output should make that obvious. Forging
  the appearance of an in-person commit would be worse than just not
  signing at all.

## The shape of the answer

A second, dedicated SSH identity for Claude Code, with deliberately
different properties from the personal one:

- **Lower-trust by construction.** It can sign commits, full stop. It
  cannot authenticate to GitHub, cannot push, cannot clone anything that
  requires SSH auth. Registered on GitHub as a Signing Key, not an
  Authentication Key. If it ever leaks, the blast radius is forged
  commits on repos I touch, not stolen code or impersonation on PRs.
- **Independently revocable.** Separate item in 1Password, separate
  registration on GitHub. Rotating it doesn't disturb my personal
  identity.
- **Activates only for Claude Code.** Interactive terminal sessions still
  sign with the 1Password personal key. Claude Code subprocesses pick
  up an alternate `SSH_AUTH_SOCK` and `GIT_CONFIG_GLOBAL` via
  `~/.claude/settings.json`, so the agent identity is selected by *what
  is running git*, not by repo path or branch.
- **Source of truth in 1Password.** The encrypted key bytes live in the
  pixee 1Password vault and are piped from `op read` straight into
  `ssh-add -` over stdin. The private key never lands on disk on any
  machine.

## What this is explicitly not

- Not a general-purpose authentication key. It does one thing.
- Not for non-Claude work. Anything I type at a terminal still uses my
  personal key. The two identities don't share secrets, don't share
  agents, and don't share fate.
- Not a long-term human identity. It's tied to "work I delegate to
  Claude at Pixee." If I leave Pixee, this whole identity gets revoked
  and either retired or regenerated under a different account.

## What's where

- `claude/` (this directory): Ansible bits that install Claude Code and
  manage `~/.claude/settings.json`.
- `claude-signing/`: the LaunchAgent that exposes the agent identity at
  a fixed ssh-agent socket, plus the gitconfig overlay that flips
  signing config when Claude is the caller.
- `ssh/allowed_signers`: includes the agent pubkey alongside the
  personal one so `git log --show-signature` resolves locally.
