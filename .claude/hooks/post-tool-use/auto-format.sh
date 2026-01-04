#!/bin/bash

# PostToolUse Auto-Format Hook
# Automatically formats files after Edit or Write operations

set -euo pipefail

# Read hook input from stdin
HOOK_INPUT=$(cat)

# Extract tool name and file path
TOOL_NAME=$(echo "$HOOK_INPUT" | jq -r '.tool_name // empty')
FILE_PATH=$(echo "$HOOK_INPUT" | jq -r '.tool_input.file_path // empty')

# Only process Edit and Write tools
if [[ "$TOOL_NAME" != "Edit" && "$TOOL_NAME" != "Write" ]]; then
  exit 0
fi

# Validate file path exists
if [[ -z "$FILE_PATH" || ! -f "$FILE_PATH" ]]; then
  exit 0
fi

# Get file extension
EXT="${FILE_PATH##*.}"

# Format based on file type
case "$EXT" in
  ts|tsx|js|jsx|mjs|cjs)
    # TypeScript/JavaScript - use prettier if available
    if command -v prettier &>/dev/null; then
      prettier --write "$FILE_PATH" 2>/dev/null || true
    elif command -v npx &>/dev/null && [[ -f "node_modules/.bin/prettier" ]]; then
      npx prettier --write "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
  json)
    # JSON - use prettier if available
    if command -v prettier &>/dev/null; then
      prettier --write "$FILE_PATH" 2>/dev/null || true
    elif command -v jq &>/dev/null; then
      # Fallback to jq for JSON formatting
      TEMP_FILE="${FILE_PATH}.tmp.$$"
      if jq '.' "$FILE_PATH" > "$TEMP_FILE" 2>/dev/null; then
        mv "$TEMP_FILE" "$FILE_PATH"
      else
        rm -f "$TEMP_FILE"
      fi
    fi
    ;;
  py)
    # Python - use black or ruff if available
    if command -v black &>/dev/null; then
      black --quiet "$FILE_PATH" 2>/dev/null || true
    elif command -v ruff &>/dev/null; then
      ruff format "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
  go)
    # Go - use gofmt
    if command -v gofmt &>/dev/null; then
      gofmt -w "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
  rs)
    # Rust - use rustfmt
    if command -v rustfmt &>/dev/null; then
      rustfmt "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
  css|scss|less)
    # CSS - use prettier if available
    if command -v prettier &>/dev/null; then
      prettier --write "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
  md)
    # Markdown - use prettier if available
    if command -v prettier &>/dev/null; then
      prettier --write "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
  yaml|yml)
    # YAML - use prettier if available
    if command -v prettier &>/dev/null; then
      prettier --write "$FILE_PATH" 2>/dev/null || true
    fi
    ;;
esac

# Always exit 0 to not block the tool
exit 0
