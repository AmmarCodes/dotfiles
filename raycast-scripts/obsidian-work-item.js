#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Add work item to Obsidian
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 💻
// @raycast.packageName Obsidian Utils

// Documentation:
// @raycast.description Add work item to Obsidian
// @raycast.author AmmarCodes
// @raycast.authorURL https://raycast.com/AmmarCodes

const browser = "Brave Browser";
const workItemFolder = "2.Areas/gitlab/work/";

const { execSync } = require("child_process");

const openObsidianUrl = (url) => {
	const obsidianUrl = `obsidian://advanced-uri?vault=obsidian&${url}`;

	execSync(`open "${obsidianUrl}"`, { encoding: "utf-8" });
};

const url = execSync(
	`osascript -e 'tell application "${browser}" to get URL of active tab of first window'`,
	{ encoding: "utf-8" },
).replace(/^\s+|\s+$/g, "");

const title = execSync(
	`osascript -e 'tell application "${browser}" to get title of active tab of first window'`,
	{ encoding: "utf-8" },
)
	.replace(/^\s+|\s+$/g, "")
	// remove unnecessary text from the title e.g. (!123) merge requests etc.
	.replace(/\((!|#)\d+\).*$/, "")
	.trim();

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
done_date:
priority: 2
status: doing
---
# ${title}

## Updates

- ${todayDate} item added to Obsidian
`;

const workItemPath = encodeURIComponent(workItemFolder);
const filePath = encodeURIComponent(title.replaceAll(/(\/|\\|\:|\.)/g, ""));
const data = encodeURIComponent(content);

// add the work item to the worklog file
const workItem = encodeURIComponent(`- [[${filePath}|${title}]]`);
openObsidianUrl(
	`filepath=2.Areas/gitlab/Worklog.md&mode=append&data=${workItem}&openmode=silent`,
);

openObsidianUrl(
	`filepath=${workItemPath + filePath}.md&data=${data}&openmode=tab`,
);
