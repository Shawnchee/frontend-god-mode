#!/usr/bin/env bash
set -euo pipefail

# frontend-god-mode installer
# Installs the skill into ~/.claude/skills/frontend-god-mode

SKILL_NAME="frontend-god-mode"
TARGET_DIR="${HOME}/.claude/skills/${SKILL_NAME}"
REPO_URL="https://github.com/Shawnchee/frontend-god-mode"
TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TEMP_DIR}"' EXIT

echo ""
echo "═══════════════════════════════════════════════════"
echo "  Installing frontend-god-mode → ${TARGET_DIR}"
echo "═══════════════════════════════════════════════════"
echo ""

# Clone the repo into a temp dir
if command -v git >/dev/null 2>&1; then
  git clone --depth 1 "${REPO_URL}.git" "${TEMP_DIR}/repo" >/dev/null 2>&1 || {
    echo "✗ git clone failed. Falling back to local install."
    LOCAL_INSTALL=true
  }
else
  echo "✗ git not found. Falling back to local install."
  LOCAL_INSTALL=true
fi

# If running locally from the repo root, just copy from here
if [ "${LOCAL_INSTALL:-false}" = "true" ] || [ -f "./frontend-god-mode/SKILL.md" ]; then
  SOURCE_DIR="./frontend-god-mode"
else
  SOURCE_DIR="${TEMP_DIR}/repo/frontend-god-mode"
fi

if [ ! -f "${SOURCE_DIR}/SKILL.md" ]; then
  echo "✗ Could not find skill source at ${SOURCE_DIR}"
  exit 1
fi

# Backup existing install (outside skills/, so Claude Code doesn't load it as a duplicate skill)
if [ -d "${TARGET_DIR}" ]; then
  BACKUP_ROOT="${HOME}/.claude/skill-backups"
  BACKUP="${BACKUP_ROOT}/${SKILL_NAME}.$(date +%s)"
  mkdir -p "${BACKUP_ROOT}"
  echo "→ Existing install found. Backing up to ${BACKUP}"
  mv "${TARGET_DIR}" "${BACKUP}"
fi

mkdir -p "${TARGET_DIR}"
cp -R "${SOURCE_DIR}/." "${TARGET_DIR}/"

echo ""
echo "✓ Installed to ${TARGET_DIR}"
echo ""
echo "Next steps:"
echo "  1. Restart Claude Code (close and reopen the terminal)"
echo "  2. Try: \"build me a landing page for a small-batch coffee roaster\""
echo "  3. Or run the setup wizard: \"/frontend-god-mode setup\""
echo ""
echo "Optional integrations (install when needed):"
echo "  • Framer Motion:  npm install framer-motion"
echo "  • 21st.dev MCP:   add to ~/.claude.json (see README)"
echo "  • React Bits:     npx shadcn@latest add @react-bits/<Component>"
echo ""
