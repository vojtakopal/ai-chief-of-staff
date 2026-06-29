#!/bin/bash

# AI Chief of Staff — Installer
# Sets up your personal AI operating system in ~/.claude/

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Detect whether we have a terminal to prompt against. When run as a
# session-start / setup script there is no TTY, so we skip the interactive
# prompts and install files non-interactively. Values can still be supplied
# via environment variables (USER_NAME, WORK_EMAIL, etc.).
INTERACTIVE=1
if [ ! -t 0 ]; then
    INTERACTIVE=0
fi

echo ""
echo -e "${BOLD}============================================${NC}"
echo -e "${BOLD}   AI Chief of Staff — Setup${NC}"
echo -e "${BOLD}============================================${NC}"
echo ""
echo "This will set up your personal AI operating system"
echo "by installing template files to ~/.claude/"
echo ""

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    echo -e "${YELLOW}Warning: Claude Code CLI not found.${NC}"
    echo "Install it from: https://docs.anthropic.com/en/docs/claude-code"
    echo ""
    if [ "$INTERACTIVE" = "1" ]; then
        read -p "Continue anyway? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
fi

# Gather user info (interactive only). Non-interactive runs use environment
# variables where provided and fall back to leaving placeholders untouched.
if [ "$INTERACTIVE" = "1" ]; then
    echo -e "${BLUE}Let's personalize your setup.${NC}"
    echo ""

    read -p "Your full name: " USER_NAME
    read -p "Your first name (for email sign-offs): " FIRST_NAME
    read -p "Your role/title: " USER_ROLE
    read -p "Your company: " USER_COMPANY
    read -p "Work email: " WORK_EMAIL
    read -p "Personal email: " PERSONAL_EMAIL
    read -p "Company website (e.g., example.com): " COMPANY_URL

    echo ""
    echo -e "${BLUE}Time constraints (leave blank to skip):${NC}"
    read -p "Home by what time? (e.g., 6:00 PM): " DINNER_TIME
    read -p "Earliest meeting time? (e.g., 9:00 AM): " EARLIEST_MEETING

    echo ""
    echo -e "${BLUE}Preferences:${NC}"
    read -p "Currency (USD/CAD/EUR/GBP): " CURRENCY
    read -p "Timezone (e.g., America/New_York): " TIMEZONE
else
    echo -e "${BLUE}No terminal detected - installing non-interactively.${NC}"
    echo ""
fi

CURRENCY=${CURRENCY:-USD}
TIMEZONE=${TIMEZONE:-America/New_York}

# Create directory structure
echo ""
echo -e "${GREEN}Creating directory structure...${NC}"

CLAUDE_DIR="$HOME/.claude"
mkdir -p "$CLAUDE_DIR"
mkdir -p "$CLAUDE_DIR/contacts"
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/objectives"
mkdir -p "$CLAUDE_DIR/task-outputs"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Copy and customize CLAUDE.md
echo -e "${GREEN}Customizing CLAUDE.md...${NC}"

cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Replace placeholders
sed -i.bak "s/{{YOUR_NAME}}/$USER_NAME/g" "$CLAUDE_DIR/CLAUDE.md"
sed -i.bak "s/{{YOUR_FIRST_NAME}}/$FIRST_NAME/g" "$CLAUDE_DIR/CLAUDE.md"
sed -i.bak "s/{{YOUR_ROLE}}/$USER_ROLE/g" "$CLAUDE_DIR/CLAUDE.md"
sed -i.bak "s/{{YOUR_COMPANY}}/$USER_COMPANY/g" "$CLAUDE_DIR/CLAUDE.md"
sed -i.bak "s/{{WORK_EMAIL}}/$WORK_EMAIL/g" "$CLAUDE_DIR/CLAUDE.md"
sed -i.bak "s/{{PERSONAL_EMAIL}}/$PERSONAL_EMAIL/g" "$CLAUDE_DIR/CLAUDE.md"
sed -i.bak "s|{{COMPANY_URL}}|$COMPANY_URL|g" "$CLAUDE_DIR/CLAUDE.md"
sed -i.bak "s/{{CURRENCY}}/$CURRENCY/g" "$CLAUDE_DIR/CLAUDE.md"
sed -i.bak "s|{{TIMEZONE}}|$TIMEZONE|g" "$CLAUDE_DIR/CLAUDE.md"

if [ -n "$DINNER_TIME" ]; then
    sed -i.bak "s/{{DINNER_TIME}}/$DINNER_TIME/g" "$CLAUDE_DIR/CLAUDE.md"
fi
if [ -n "$EARLIEST_MEETING" ]; then
    sed -i.bak "s/{{EARLIEST_MEETING_TIME}}/$EARLIEST_MEETING/g" "$CLAUDE_DIR/CLAUDE.md"
fi

# Clean up sed backup files
rm -f "$CLAUDE_DIR/CLAUDE.md.bak"

# Copy template files (don't overwrite existing)
echo -e "${GREEN}Installing template files...${NC}"

copy_if_missing() {
    local src="$1"
    local dest="$2"
    if [ ! -f "$dest" ]; then
        cp "$src" "$dest"
        echo "  Created: $dest"
    else
        echo -e "  ${YELLOW}Skipped (already exists):${NC} $dest"
    fi
}

copy_if_missing "$SCRIPT_DIR/goals.yaml" "$CLAUDE_DIR/goals.yaml"
copy_if_missing "$SCRIPT_DIR/my-tasks.yaml" "$CLAUDE_DIR/my-tasks.yaml"
copy_if_missing "$SCRIPT_DIR/schedules.yaml" "$CLAUDE_DIR/schedules.yaml"
copy_if_missing "$SCRIPT_DIR/contacts/example-contact.md" "$CLAUDE_DIR/contacts/example-contact.md"

# Copy commands
for cmd in "$SCRIPT_DIR/commands/"*.md; do
    if [ -f "$cmd" ]; then
        filename=$(basename "$cmd")
        copy_if_missing "$cmd" "$CLAUDE_DIR/commands/$filename"
    fi
done

# ---------------------------------------------------------------------------
# GitHub CLI + project #42 access
#
# The data team board (apify org, Projects v2 #42) is only reachable via the gh
# GraphQL API. The container is ephemeral, so install gh and dump #42 on every
# startup. Everything here is best-effort: a failure must never abort setup, so
# each step is guarded and set -e is relaxed for this block.
# ---------------------------------------------------------------------------
echo ""
echo -e "${GREEN}Setting up GitHub CLI + project #42...${NC}"
set +e

install_gh() {
    command -v gh >/dev/null 2>&1 && return 0
    local arch ver tmp
    case "$(uname -m)" in
        x86_64|amd64) arch=amd64 ;;
        aarch64|arm64) arch=arm64 ;;
        *) echo "  Unsupported arch $(uname -m); skipping gh install"; return 1 ;;
    esac
    # Resolve the latest tag via the redirect (avoids the rate-limited releases API).
    ver=$(curl -fsSL -o /dev/null -w '%{url_effective}' \
        https://github.com/cli/cli/releases/latest 2>/dev/null | sed 's#.*/tag/v##')
    [ -z "$ver" ] && { echo "  Could not resolve gh version; skipping"; return 1; }
    tmp=$(mktemp -d)
    if curl -fsSL "https://github.com/cli/cli/releases/download/v${ver}/gh_${ver}_linux_${arch}.tar.gz" \
        -o "$tmp/gh.tar.gz" 2>/dev/null && tar -xzf "$tmp/gh.tar.gz" -C "$tmp" 2>/dev/null; then
        mkdir -p "$HOME/.local/bin"
        cp "$tmp"/gh_*/bin/gh "$HOME/.local/bin/gh" && echo "  Installed gh v${ver} to ~/.local/bin"
    else
        echo "  gh download failed; skipping"
    fi
    rm -rf "$tmp"
    export PATH="$HOME/.local/bin:$PATH"
    command -v gh >/dev/null 2>&1
}

install_gh
export PATH="$HOME/.local/bin:$PATH"

# gh reads GH_TOKEN / GITHUB_TOKEN from the environment natively. Note: in the
# Claude Code web environment, outbound GitHub traffic is gated through the Claude
# GitHub App and the GraphQL API is blocked by the egress proxy. Projects v2 (#42)
# is GraphQL-only, so the live dump only works OUTSIDE the web env (local gh / CI).
# Here we attempt it, and fall back to a committed snapshot at data/p42.json.
GH_TOK="${GH_TOKEN:-${GITHUB_TOKEN:-}}"
mkdir -p "$CLAUDE_DIR/data"
if command -v gh >/dev/null 2>&1 && [ -n "$GH_TOK" ] && \
   bash "$SCRIPT_DIR/scripts/gh-project42-dump.sh" \
     > "$CLAUDE_DIR/data/p42.json" 2>"$CLAUDE_DIR/data/p42.err"; then
    echo "  Project #42 dumped live to ~/.claude/data/p42.json"
else
    rm -f "$CLAUDE_DIR/data/p42.json"
    if grep -qi 'graphql proxying\|not enabled for this session' "$CLAUDE_DIR/data/p42.err" 2>/dev/null; then
        echo -e "  ${YELLOW}Live #42 dump blocked by the egress proxy${NC} (GitHub GraphQL"
        echo "    disabled / REST gated via the Claude GitHub App). Expected in web sessions."
    else
        echo -e "  ${YELLOW}Live #42 dump unavailable${NC} (see ~/.claude/data/p42.err)."
    fi
    if [ -s "$SCRIPT_DIR/data/p42.json" ]; then
        cp "$SCRIPT_DIR/data/p42.json" "$CLAUDE_DIR/data/p42.json"
        echo "    Using committed snapshot data/p42.json (refresh it from local gh / CI)."
    else
        echo "    No committed snapshot at data/p42.json yet - /1on1 and /weekly-retro"
        echo "    will note #42 is unavailable until one is added."
    fi
fi

set -e

# Summary
echo ""
echo -e "${BOLD}============================================${NC}"
echo -e "${GREEN}${BOLD}   Setup Complete!${NC}"
echo -e "${BOLD}============================================${NC}"
echo ""
echo "Files installed to: $CLAUDE_DIR/"
echo ""
echo -e "${BOLD}Installed:${NC}"
echo "  CLAUDE.md          — Your AI operating system config"
echo "  goals.yaml         — Quarterly objectives (edit these!)"
echo "  my-tasks.yaml      — Task tracking"
echo "  schedules.yaml     — Automation schedules"
echo "  contacts/          — Contact files"
echo "  commands/          — Skill definitions (gm, triage, my-tasks, enrich)"
echo ""
echo -e "${BOLD}Next steps:${NC}"
echo ""
echo -e "  ${BLUE}1.${NC} Connect MCP servers (at minimum: Gmail + Google Calendar)"
echo "     See docs/mcp-servers.md for installation instructions"
echo ""
echo -e "  ${BLUE}2.${NC} Edit your goals:"
echo "     Open $CLAUDE_DIR/goals.yaml and define your real objectives"
echo ""
echo -e "  ${BLUE}3.${NC} Customize your CLAUDE.md:"
echo "     Open $CLAUDE_DIR/CLAUDE.md and fill in the remaining placeholders"
echo "     (writing style, team members, hard constraints)"
echo ""
echo -e "  ${BLUE}4.${NC} Try it out:"
echo "     $ claude"
echo "     > /gm            # Morning briefing"
echo "     > /triage         # Inbox triage"
echo "     > /my-tasks list  # See your tasks"
echo ""
echo -e "${YELLOW}Tip:${NC} The more you customize CLAUDE.md, the better Claude performs."
echo "     Spend 30 minutes filling in your writing style examples and team info."
echo ""
