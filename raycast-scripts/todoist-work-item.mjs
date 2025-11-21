#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Add work item to Todoist
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 💻
// @raycast.packageName Todoist Utils
// @raycast.argument1 { "type": "text", "placeholder": "Any prefix to add for the task?", "optional": true }

// Documentation:
// @raycast.description Add work item to Todoist
// @raycast.author AmmarCodes
// @raycast.authorURL https://raycast.com/AmmarCodes

import { TodoistApi } from "@doist/todoist-api-typescript";
import { execSync } from "child_process";
import dotenv from "dotenv";
dotenv.config({ path: "~/.private_exports" });
if (!process.env.TODOIST_TOKEN) {
  process.exit("TODOIST_TOKEN env var does not exist");
}
let prefix = process.argv.slice(2)[0] || "";
if (prefix) prefix += " ";

const defaultBrowser = execSync(
  "defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure | awk -F'\"' '/http;/{print window[(NR)-1]}{window[NR]=$2}'",
  { encoding: "utf-8" },
).trim();

const browsers = {
  "com.brave.browser": "Brave Browser",
  "net.imput.helium": "Helium",
};

const browser = browsers[defaultBrowser];
if (!browser) console.error("Could not figure the default browser!");

let title = execSync(
  `osascript -e 'tell application "${browser}" to get title of active tab of first window'`,
  { encoding: "utf-8" },
)
  .replace(/^\s+|\s+$/g, "")
  // remove unnecessary text from the title e.g. (!123) merge requests etc.
  .replace(/\((!|#)\d+\).*$/, "")
  .trim();

const url = execSync(
  `osascript -e 'tell application "${browser}" to get URL of active tab of first window'`,
  { encoding: "utf-8" },
).replace(/^\s+|\s+$/g, "");

const api = new TodoistApi(process.env.TODOIST_TOKEN);
let taskId;
try {
  const task = await api.addTask({
    content: prefix + (url ? `[${title}](${url})` : title),
    projectId: 2329633844,
    dueString: "today",
    // labels: ["next-action"],
    // dueLang: "en",
    // priority: 4,
  });
  taskId = task.id;
} catch (error) {
  console.error(error);
}
