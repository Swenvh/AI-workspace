#!/bin/bash
# Installs the tools used by the repo's skills:
#   - SkillSpector CLI (skill-inspector)
#   - ffmpeg + yt-dlp (watch)
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Pinned to the reviewed commit (v2.12.0) to avoid pulling unreviewed upstream changes.
SKILLSPECTOR_REF="89e90872e2ec813bcb137bf6b3145c92e55811ae"

if ! { command -v skillspector >/dev/null 2>&1 && skillspector --version 2>/dev/null | grep -q "v2.12.0"; }; then
  uv tool install --force --python 3.12 "git+https://github.com/NVIDIA/SkillSpector.git@${SKILLSPECTOR_REF}"
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  apt-get install -y -qq ffmpeg || { apt-get update -qq && apt-get install -y -qq ffmpeg; }
fi

# yt-dlp is left unpinned: YouTube changes often break older releases.
if ! command -v yt-dlp >/dev/null 2>&1; then
  uv tool install yt-dlp
fi

echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "${CLAUDE_ENV_FILE:-/dev/null}"
