/**
 * Auto-Format Plugin
 * Runs formatters after file edits (non-blocking)
 */

const FORMATTERS: Record<string, string> = {
  ".js": "npx prettier --write",
  ".ts": "npx prettier --write",
  ".jsx": "npx prettier --write",
  ".tsx": "npx prettier --write",
  ".json": "npx prettier --write",
  ".md": "npx prettier --write",
  ".py": "black",
  ".go": "gofmt -w",
};

export const AutoFormatPlugin = async ({ $ }) => {
  return {
    "tool.execute.after": async (input, output) => {
      if (!["write", "edit"].includes(input.tool)) {
        return;
      }

      const filePath =
        input.args?.file_path || input.args?.filePath || input.args?.path || "";
      if (!filePath) return;

      const ext = filePath.match(/\.[^.]+$/)?.[0]?.toLowerCase();
      const formatter = ext ? FORMATTERS[ext] : null;

      if (formatter) {
        try {
          const [cmd, ...args] = formatter.split(" ");
          await $`${cmd} ${args} ${filePath}`.quiet();
        } catch {
          // Ignore formatter errors - non-blocking
        }
      }
    },
  };
};
