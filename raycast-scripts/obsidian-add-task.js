#!/usr/bin/env node

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title Add task to Obsidian
// @raycast.mode silent

// Optional parameters:
// @raycast.icon ✅
// @raycast.packageName Obsidian Utils
// @raycast.argument1 { "type": "text", "placeholder": "What to add?",}

// Documentation:
// @raycast.description Add task to Obsidian
// @raycast.author AmmarCodes
// @raycast.authorURL https://raycast.com/AmmarCodes

const { execSync } = require("child_process");
const tasksPath = "Tasks.md";

const openObsidianUrl = (url) => {
	const obsidianUrl = `obsidian://advanced-uri?vault=obsidian&${url}`;

	execSync(`open "${obsidianUrl}"`, { encoding: "utf-8" });
};

const today = new Date();
const yyyy = today.getFullYear();
const mm = String(today.getMonth() + 1).padStart(2, "0");
const dd = String(today.getDate()).padStart(2, "0");

const todayDate = `${yyyy}-${mm}-${dd}`;

const title = process.argv.slice(2)[0];
let content = `- [ ] ${title} 📅 ${todayDate}`;

const data = encodeURIComponent(content);

openObsidianUrl(
	`filepath=${tasksPath}&data=${data}&mode=append&openmode=silent`,
);
