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

# watch: preconfigure the Gemini engine so the first-run wizard is skipped.
# The key itself is never stored here; it comes from the GEMINI_API_KEY
# environment variable set in the cloud environment settings.
WATCH_CONFIG="$HOME/.config/watch/.env"
if [ ! -f "$WATCH_CONFIG" ]; then
  mkdir -p "$(dirname "$WATCH_CONFIG")"
  (umask 077 && printf 'WATCH_ENGINE="gemini"\nWATCH_DETAIL="balanced"\nSETUP_COMPLETE="true"\n' > "$WATCH_CONFIG")
fi

echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "${CLAUDE_ENV_FILE:-/dev/null}"
