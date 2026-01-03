#!/bin/bash
# MainAgent サブエージェント選択テスト
# Usage: ./run-tests.sh [category] [test_id]
#   category: single-select, ambiguous, multi-agent, edge-case, all (default: all)
#   test_id:  A1, B2, etc. (optional, runs specific test)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEST_CASES="$SCRIPT_DIR/test-cases.json"
RESULTS_FILE="$SCRIPT_DIR/results.md"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check dependencies
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

if ! command -v claude &> /dev/null; then
    echo "Error: claude CLI is required."
    exit 1
fi

# Parse arguments
CATEGORY="${1:-all}"
TEST_ID="${2:-}"

# Initialize results file if running all tests
init_results() {
    cat > "$RESULTS_FILE" << EOF
# エージェント選択テスト結果

**実行日時**: $(date '+%Y-%m-%d %H:%M:%S')
**テストスイート**: agent-selection

---

## サマリー

| カテゴリ | Pass | Fail | Skip |
|---------|------|------|------|
| single-select | - | - | - |
| ambiguous | - | - | - |
| multi-agent | - | - | - |
| edge-case | - | - | - |

---

## 詳細結果

EOF
}

# Run a single test case
run_test() {
    local id="$1"
    local input="$2"
    local expected="$3"
    local note="$4"
    local category="$5"

    echo -e "${YELLOW}Running test $id...${NC}"
    echo "  Input: $input"

    # Run claude CLI with the test input
    # Using --print to get raw output, --max-tokens to limit response
    local output
    output=$(claude --print -p "$input どのエージェントを使うべきか、subagent_typeを明示して答えて。実装は不要。" 2>&1) || true

    # Extract agent selection from output (look for subagent_type patterns)
    local selected_agents
    selected_agents=$(echo "$output" | grep -oE 'subagent_type[=:]["'\''"]?([a-z-]+)' | sed 's/.*[=:]["'\'']\?//' | tr '\n' ',' | sed 's/,$//')

    # Also check for agent mentions in natural language
    if [ -z "$selected_agents" ]; then
        selected_agents=$(echo "$output" | grep -oE '\b(nextjs-developer|python-pro|terraform-engineer|kubernetes-specialist|code-reviewer|ci-cd-fixer|error-recovery|llm-architect|prompt-engineer|mcp-developer|multi-agent-coordinator|project-analyzer|project-scaffolder|project-state-updater|refactoring-specialist|typescript-pro)\b' | sort -u | tr '\n' ',' | sed 's/,$//')
    fi

    # Determine pass/fail
    local result="UNKNOWN"
    local result_color="$YELLOW"

    if [ -z "$selected_agents" ]; then
        # Check if question was asked (for ambiguous/edge cases)
        if echo "$output" | grep -qiE '(どの|which|what|どんな|選んで|specify|clarify|\?)'; then
            result="QUESTION"
            result_color="$YELLOW"
        else
            result="NO_AGENT"
            result_color="$RED"
        fi
    else
        # Check if expected agent was selected
        local found=false
        for exp in $(echo "$expected" | tr ',' '\n'); do
            if echo "$selected_agents" | grep -q "$exp"; then
                found=true
                break
            fi
        done

        if $found; then
            result="PASS"
            result_color="$GREEN"
        else
            result="FAIL"
            result_color="$RED"
        fi
    fi

    echo -e "  Selected: ${selected_agents:-none}"
    echo -e "  Expected: $expected"
    echo -e "  Result: ${result_color}${result}${NC}"
    echo ""

    # Append to results file
    cat >> "$RESULTS_FILE" << EOF
### $id: $note

- **入力**: $input
- **期待**: $expected
- **選択**: ${selected_agents:-none}
- **結果**: $result

<details>
<summary>出力詳細</summary>

\`\`\`
$(echo "$output" | head -50)
\`\`\`

</details>

---

EOF
}

# Main execution
main() {
    echo "======================================"
    echo "  Agent Selection Test Runner"
    echo "======================================"
    echo ""

    # Initialize results file
    if [ "$CATEGORY" = "all" ] && [ -z "$TEST_ID" ]; then
        init_results
    fi

    # Get test cases
    local cases
    if [ -n "$TEST_ID" ]; then
        cases=$(jq -c ".cases[] | select(.id == \"$TEST_ID\")" "$TEST_CASES")
    elif [ "$CATEGORY" != "all" ]; then
        cases=$(jq -c ".cases[] | select(.category == \"$CATEGORY\")" "$TEST_CASES")
    else
        cases=$(jq -c '.cases[]' "$TEST_CASES")
    fi

    # Run tests
    local pass=0 fail=0 skip=0

    echo "$cases" | while IFS= read -r case; do
        [ -z "$case" ] && continue

        local id=$(echo "$case" | jq -r '.id')
        local input=$(echo "$case" | jq -r '.input')
        local expected=$(echo "$case" | jq -r '.expected | join(",")')
        local note=$(echo "$case" | jq -r '.note')
        local category=$(echo "$case" | jq -r '.category')

        run_test "$id" "$input" "$expected" "$note" "$category"

        # Add delay to avoid rate limiting
        sleep 2
    done

    echo "======================================"
    echo "  Tests completed!"
    echo "  Results saved to: $RESULTS_FILE"
    echo "======================================"
}

main "$@"
