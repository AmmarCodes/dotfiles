/**
 * Security Scan Plugin
 * Prevents editing sensitive files like .env, credentials, keys
 */

// Patterns for sensitive files
const SENSITIVE_FILES = [
  /\.env$/,
  /\.env\./,
  /credentials/i,
  /secrets/i,
  /\.pem$/,
  /\.key$/,
  /id_rsa/,
  /id_ed25519/,
];

function isSensitiveFile(filePath: string): boolean {
  return SENSITIVE_FILES.some((pattern) => pattern.test(filePath));
}

export const SecurityScanPlugin = async ({ $ }) => {
  return {
    "tool.execute.before": async (input, output) => {
      // Only check file modification tools
      if (!["write", "edit", "patch"].includes(input.tool)) {
        return;
      }

      const filePath =
        input.args?.file_path || input.args?.filePath || input.args?.path || "";

      if (filePath && isSensitiveFile(filePath)) {
        throw new Error(
          `SECURITY BLOCK: Cannot edit sensitive file "${filePath}". Edit manually if needed.`,
        );
      }
    },
  };
};
