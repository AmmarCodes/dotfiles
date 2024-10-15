#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Add work item to Obsidian
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 💻
// @raycast.packageName Obsidian Utils
// @raycast.xargument1 { "type": "dropdown", "placeholder": "Add task to Todoist as well? pass anything for true", "optional": false, "data": [{"title": "Yes", "value": "1"}, {"title": "No", "value": "0"}] }
// @raycast.xargument2 { "type": "text", "placeholder": "Any prefix to add for the task?", "optional": true }

// Documentation:
// @raycast.description Add work item to Obsidian
// @raycast.author AmmarCodes
// @raycast.authorURL https://raycast.com/AmmarCodes

import { execSync } from "child_process";

const workItemFolder = "2.Areas/gitlab/work/";

const defaultBrowser = execSync(
  "defaults read ~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure | awk -F'\"' '/http;/{print window[(NR)-1]}{window[NR]=$2}'",
  { encoding: "utf-8" },
).trim();

const browsers = {
  "com.brave.browser": "Brave Browser",
  "company.thebrowser.browser": "Arc",
};

const browser = browsers[defaultBrowser];
if (!browser) console.error("Could not figure the default browser!");

const getObsidianUrl = (url) => `obsidian://advanced-uri?vault=obsidian&${url}`;

const openObsidianUrl = (url) => {
  const obsidianUrl = getObsidianUrl(url);

  execSync(`open "${obsidianUrl}"`, { encoding: "utf-8" });
};

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

const workItemPath = encodeURIComponent(workItemFolder);
const filePath = encodeURIComponent(title.replaceAll(/(\/|\\|\:|\.)/g, ""));

const today = new Date();
const yyyy = today.getFullYear();
const mm = String(today.getMonth() + 1).padStart(2, "0");
const dd = String(today.getDate()).padStart(2, "0");

const todayDate = `${yyyy}-${mm}-${dd}`;

let content = `---
date: "[[${todayDate}]]"
link: "${url}"
tags:
  - gitlab/work-item
  - gitlab/type/review
aliases:
  - "${title}"
done_date: "[[${todayDate}]]"
---
# ${title}

## Updates
`;

// removed from content - [ ] Review [[${filePath}]] 📅 ${todayDate}

const data = encodeURIComponent(content);

// add the work item to the worklog file
const workItem = encodeURIComponent(`- [[${filePath}|${title}]]`);
openObsidianUrl(
  `filepath=2.Areas/gitlab/Worklog.md&mode=append&data=${workItem}&openmode=silent`,
);

openObsidianUrl(
  `filepath=${workItemPath + filePath}.md&data=${data}&openmode=tab`,
);
