/**
 * Code Reviewer Agent
 *
 * Reviews code for quality, security, and performance issues.
 *
 * Usage:
 *   npm run agent:review
 *   npx tsx agents/code-reviewer.ts [path]
 */

import { query } from "@anthropic-ai/claude-agent-sdk";

async function main() {
  const targetPath = process.argv[2] || ".";

  const prompt = `
You are a code reviewer. Review the code in "${targetPath}" for:

1. **Security Issues**: SQL injection, XSS, hardcoded secrets, etc.
2. **Performance**: Inefficient algorithms, memory leaks, N+1 queries
3. **Code Quality**: Readability, maintainability, best practices
4. **Bugs**: Potential runtime errors, edge cases

Provide a structured report with:
- Critical issues (must fix)
- Warnings (should fix)
- Suggestions (nice to have)

Be concise and actionable.
`;

  console.log(`🔍 Reviewing code in: ${targetPath}`);
  console.log("---\n");

  for await (const message of query({
    prompt,
    options: {
      allowedTools: ["Read", "Glob", "Grep"],
      // Read-only - no edits
    },
  })) {
    if (message.type === "assistant" && message.message?.content) {
      for (const block of message.message.content) {
        if (block.type === "text") {
          process.stdout.write(block.text);
        }
      }
    } else if (message.type === "result") {
      console.log("\n\n---");
      console.log("✅ Review completed");
    }
  }
}

main().catch(console.error);
