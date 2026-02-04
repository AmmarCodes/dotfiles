import type { Plugin } from "@opencode-ai/plugin";

export const TerminalBell: Plugin = async ({
  project,
  client,
  $,
  directory,
  worktree,
}) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`noti -m "Session completed!" -t "opencode"`;
      }
    },
  };
};
