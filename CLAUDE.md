# AI-workspace

This repo is the user's toolbox for Claude Code skills. New skills are collected, security-checked and tried out here, then copied into the project repos where they are used.

Contents:
- `.claude/skills/`: installed skills
- `.claude/references/`: shared checklists that some skills link to (`../../references/...`)
- `.claude/skills/_licenses/`: licenses of bundled third-party skill sets
- `.claude/hooks/session-start.sh`: installs the tools the skills need (SkillSpector CLI, ffmpeg, yt-dlp) and preconfigures `watch`

## Security check before installing anything

Before installing any skill, script, CLI or other third-party code, check it first:

1. Download it to the scratchpad or a temporary directory, never straight into this repo. Do not run anything from it yet, including install scripts.
2. Scan it with SkillSpector: `skillspector scan <path> --no-llm --format json --output <report.json>`. If `skillspector` is missing, say so and do a manual review instead.
3. Read the source around every HIGH or CRITICAL finding, plus any finding involving network access, credentials, shell execution or persistence. The score alone is not the verdict.
4. Report the result to the user as APPROVE, CAUTION or REJECT, with the key evidence.
5. Only install after that report, and only if the user still wants it.

The `skill-inspector` skill describes this review in detail.

Once approved, install skills here in `.claude/skills/<name>/` and push to `main`. Leave out plugin hooks, tests and dev tooling unless the user asks for them.

## Copying skills to a project repo

When the user asks to put skills into another repo (e.g. "zet `no-ai-slop` in repo `mijn-project`"):

1. Add that repo to the session and clone it.
2. Copy the requested skill folders to its `.claude/skills/`. If a skill links to `../../references/...`, copy the files it needs to that repo's `.claude/references/` too.
3. Copy the matching license from `.claude/skills/_licenses/` for third-party skill sets.
4. Only if the user asks: also copy the security-check section of this `CLAUDE.md` and `.claude/hooks/session-start.sh` plus its registration in `.claude/settings.json`. Merge them into existing files, never overwrite.
5. Commit and push following that repo's own conventions, and tell the user which branch it landed on.

The user writes in Dutch or English; reply in the language they use.
