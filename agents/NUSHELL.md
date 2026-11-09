# Nushell Instructions

## Shell Preference

- Prefer Nushell (`nu`) for shell operations and automation.
- Prefer the Nushell MCP when available.
- Use `nu -c` when the MCP is unavailable and Nushell is installed.
- Never assume the execution shell is Nushell.
- Do not use Bash syntax inside Nushell commands.

## Command Selection

- Prefer Nushell built-ins for filesystem operations, structured data, and environment inspection.
- Prefer structured pipelines over text parsing.
- Use external tools when they are more appropriate or efficient.
- Preserve RTK usage rules when invoking supported external commands.
- Do not replace `rg`, `git`, or other specialized tools solely to enforce Nushell usage.

## Execution

- Use the Nushell MCP `evaluate` tool for suitable operations.
- Use `list_commands` and `command_help` when unsure about Nushell syntax.
- Use the shell executor for commands that require interactive sessions or unsupported MCP capabilities.
- Do not rewrite existing shell scripts unless requested.
- Check command exit status and errors.
