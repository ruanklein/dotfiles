# Agent Instructions

## Command output (RTK)

Codex: read `~/.codex/RTK.md`. Claude: read `~/.claude/RTK.md`.

## Agent Orchestration Policy

Codex: read `~/.codex/ORCHESTRATION.md`. Claude: read `~/.claude/ORCHESTRATION.md`.

## Containers

This machine (Apple silicon, macOS 26+) does **not** use Docker, Colima, Lima, or Podman.
Linux containers run through **Apple Container** (`container` CLI).

- Never assume `docker`/`docker compose` commands exist here; translate them to `container` equivalents.
- Before any container task (run, build, images, networks, machines, registries), read the skill:
  `~/.agents/skills/container/SKILL.md`
- Command groups are singular (`container image ls`, not `container images`). When in doubt, run `container <group> --help`.

## Custom instructions

Read if file exists.
Codex: read `~/.codex/CUSTOM.md`. Claude: read `~/.claude/CUSTOM.md`.
