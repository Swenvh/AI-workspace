#!/bin/bash
# Installs the SkillSpector CLI used by the skill-inspector skill.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# Pinned to the reviewed commit (v2.12.0) to avoid pulling unreviewed upstream changes.
SKILLSPECTOR_REF="89e90872e2ec813bcb137bf6b3145c92e55811ae"

if command -v skillspector >/dev/null 2>&1 && skillspector --version 2>/dev/null | grep -q "v2.12.0"; then
  exit 0
fi

uv tool install --force --python 3.12 "git+https://github.com/NVIDIA/SkillSpector.git@${SKILLSPECTOR_REF}"
echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "${CLAUDE_ENV_FILE:-/dev/null}"
