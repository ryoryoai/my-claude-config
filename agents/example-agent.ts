/**
 * Example Claude Agent SDK Agent
 *
 * Usage:
 *   npm run agent
 *   # or
 *   npx tsx agents/example-agent.ts
 */

import { query } from "@anthropic-ai/claude-agent-sdk";

async function main() {
  const prompt = process.argv[2] || "What files are in this directory? List them briefly.";

  console.log("🤖 Starting agent with prompt:", prompt);
  console.log("---");

  for await (const message of query({
    prompt,
    options: {
      allowedTools: ["Bash", "Glob", "Read", "Grep"],
    },
  })) {
    // Handle different message types
    if (message.type === "assistant") {
      // Assistant text response
      if (message.message?.content) {
        for (const block of message.message.content) {
          if (block.type === "text") {
            console.log(block.text);
          }
        }
      }
    } else if (message.type === "result") {
      // Final result
      console.log("\n---");
      console.log("✅ Agent completed");
      if (message.result) {
        console.log("Result:", message.result);
      }
    }
  }
}

main().catch(console.error);
