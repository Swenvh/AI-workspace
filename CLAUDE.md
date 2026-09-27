# AI-workspace

This repo holds Claude Code skills (`.claude/skills/`) and a SessionStart hook that installs the tools they need (SkillSpector CLI, ffmpeg, yt-dlp).

## Security check before installing anything

Before installing any skill, script, CLI or other third-party code, check it first:

1. Download it to the scratchpad or a temporary directory, never straight into this repo. Do not run anything from it yet, including install scripts.
2. Scan it with SkillSpector: `skillspector scan <path> --no-llm --format json --output <report.json>`. If `skillspector` is missing, say so and do a manual review instead.
3. Read the source around every HIGH or CRITICAL finding, plus any finding involving network access, credentials, shell execution or persistence. The score alone is not the verdict.
4. Report the result to the user as APPROVE, CAUTION or REJECT, with the key evidence.
5. Only install after that report, and only if the user still wants it.

The `skill-inspector` skill describes this review in detail.

The user writes in Dutch or English; reply in the language they use.
