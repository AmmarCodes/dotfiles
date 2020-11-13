#!/usr/bin/env /Users/ammar/.asdf/shims/node
// <bitbar.title>Title goes here</bitbar.title>
// <bitbar.version>v1.0</bitbar.version>
// <bitbar.author>Your Name</bitbar.author>
// <bitbar.author.github>your-github-username</bitbar.author.github>
// <bitbar.desc>Short description of what your plugin does.</bitbar.desc>
// <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
// <bitbar.dependencies>python,ruby,node</bitbar.dependencies>
// <bitbar.abouturl>http://url-to-about.com/</bitbar.abouturl>

const bitbar = require("bitbar");
const fetch = require("node-fetch");
const fs = require("fs");
const { DateTime, Duration } = require("luxon");

const ilceCode = 17866;
const URL = `https://ezanvakti.herokuapp.com/vakitler?ilce=${ilceCode}`;
const tmpFile = __dirname + "/prayer-data.json";
const bitbarItems = [];

let json;
let prayerData;

const getDate = () => new Date().toJSON().slice(0, 10).replace(/-/g, "/");
const writeToFile = (content) => {
	const jsonContent = JSON.stringify(content, " ", 2);
	fs.writeFileSync(tmpFile, jsonContent, "utf8", (err) => {
		if (err) {
			console.error(
				"Encountered an error while writing content to the temp file"
			);
		}
	});
};

const sampleTmpFileContent = { date: "", data: {} };

// ensure tmp file exists
if (!fs.existsSync(tmpFile)) {
	writeToFile(JSON.stringify(sampleTmpFileContent, " ", 2));
}

// read tmp file content
try {
	json = JSON.parse(fs.readFileSync(tmpFile));
} catch (err) {
	console.error(`Error encountered while reading ${tmpFile}`);
}

if (json.date === getDate()) {
	// -- get json from file
	prayerData = Object.keys(json.data).length ? json.data : null;
}

if (!prayerData) {
	// -- fetch new data
	console.log("will fetch");
	fetch(URL)
		.then((res) => res.json())
		.then((json) => {
			// -- replace json and date in tmp file
			newTmpContent = { date: getDate(), data: json };
			prayerData = json;
			writeToFile(newTmpContent);
			outputData();
		});
} else {
	outputData();
}

function outputData() {
	const times = {
		fajr: prayerData[0].Imsak,
		dhuhr: prayerData[0].Ogle,
		asr: prayerData[0].Ikindi,
		maghrib: prayerData[0].Aksam,
		isha: prayerData[0].Yatsi,
	};

	let remaining = null;
	Object.keys(times).forEach((key) => {
		const time = DateTime.fromISO(times[key]);
		times[key] = time;

		diff = time.diff(DateTime.local(), "seconds");
		diffInSeconds = diff.values.seconds;
		bitbarItems.push(key.padEnd(20) + time.toFormat("HH:mm:ss"));

		if (!remaining && diffInSeconds > 0) {
			remaining = diffInSeconds;
		}
	});

	const remainingString = Duration.fromMillis(remaining * 1000).toFormat(
		"hh:mm"
	);

	const bitbarOutput = [
		{
			text: `⏰ ${remainingString}`,
			color: bitbar.darkMode ? "white" : "red",
			dropdown: false,
		},
		bitbar.separator,
		...bitbarItems,
	];

	bitbar(bitbarOutput, { font: "IBM Plex Mono", size: "15" });
}
