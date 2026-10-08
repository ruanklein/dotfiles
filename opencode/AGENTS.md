# Agent Instructions

## Command output (RTK)

@RTK.md

## Containers — Apple Container, not Docker

This machine (Apple silicon, macOS 26+) does **not** use Docker, Colima, Lima, or Podman.
Linux containers run through **Apple Container** (`container` CLI).

- Never assume `docker`/`docker compose` commands exist here; translate them to `container` equivalents.
- Before any container task (run, build, images, networks, machines, registries), read the skill:
  `/Users/ruanf/.agents/skills/container/SKILL.md`
- Command groups are singular (`container image ls`, not `container images`). When in doubt, run `container <group> --help`.
