# Nushell Instructions

## User-Facing Shell Commands

The user's default interactive shell is Nushell (`nu`).

**Whenever providing shell commands or scripts for the user to execute, prioritize Nushell syntax.**

This rule applies to:
- Commands in explanations, documentation, and tutorials.
- Commands the user must copy and paste into a terminal.
- Installation, configuration, build, deployment, and troubleshooting instructions.
- Shell scripts generated for the user.

### Rules

1. Default to Nushell syntax for all user-facing shell commands.
2. Prefer Nushell built-in commands and structured pipelines when appropriate.
3. Generate `.nu` scripts instead of `.sh` scripts for new user-facing automation.
4. Use `#!/usr/bin/env nu` for executable Nushell scripts.
5. Never present Bash-specific syntax as if it were compatible with Nushell.
6. When a task specifically requires Bash, Zsh, or another shell, explicitly identify that shell and explain why.
7. When showing commands for multiple shells, present the Nushell version first.
8. Use external tools such as `git`, `go`, `docker`, `brew`, and `rg` normally when appropriate.
9. Verify Nushell syntax before recommending commands. Do not assume POSIX shell compatibility.

### Examples

Prefer:

```nu
$env.MY_VAR = "value"
```

Instead of:

```bash
export MY_VAR="value"
```

Prefer:

```nu
ls | where size > 10mb
```

Instead of:

```bash
find . -type f -size +10M
```

Prefer:

```nu
open package.json | get dependencies
```

Instead of:

```bash
cat package.json | jq '.dependencies'
```

## Agent Internal Execution

These instructions apply primarily to commands and scripts delivered to the user.

The agent may continue using its own supported execution tools, including Bash, Zsh, RTK, MCP servers, and other utilities, for internal operations.

Do not force Nushell for internal agent execution when doing so would reduce reliability or compatibility.

**The priority is ensuring that commands provided to the user work correctly in Nushell.**