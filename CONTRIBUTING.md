# Contributing to yijian-chengpian

## Project structure

```
skill/yijian-chengpian/   ← Canonical skill (single source of truth)
adapters/                 ← Agent-specific adapter SKILL.md files
install/                  ← Installation scripts per agent
```

## Adding a new agent adapter

1. Create `adapters/<agent>/SKILL.md` — keep it minimal, delegate to canonical skill
2. Create `install/install-<agent>.ps1` — copy canonical skill to agent's skill directory
3. Update README

## Modifying the skill

Always edit files under `skill/yijian-chengpian/` first. This is the single source of truth.

- `SKILL.md` — main entry point and workflow
- `references/setup.md` — workspace setup instructions
- `references/production.md` — daily production pipeline

## Validation

```powershell
# Check dependencies
.\skill\yijian-chengpian\scripts\check-deps.ps1

# Verify skill structure
# TODO: validate-skill.ps1
```

## Language policy

- Chinese: primary (core user base)
- Japanese: secondary (target market)
- English: installation and README
