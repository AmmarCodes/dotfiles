/**
 * Parallel Guard Plugin
 * Educational plugin that monitors Task tool usage patterns
 */

let recentTaskCalls: number[] = [];

export const ParallelGuardPlugin = async ({}) => {
  return {
    "tool.execute.before": async (input, output) => {
      if (input.tool !== "task" && input.tool !== "Task") {
        return;
      }

      const now = Date.now();

      // Track task calls within 5 second window
      recentTaskCalls = recentTaskCalls.filter((t) => now - t < 5000);
      recentTaskCalls.push(now);

      // If we see sequential task calls (not batched), log educational message
      if (recentTaskCalls.length === 2) {
        console.log(
          "[parallel-guard] Tip: Launch multiple Task calls in ONE message for parallel execution!",
        );
      }
    },
  };
};
