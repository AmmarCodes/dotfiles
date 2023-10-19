#!/usr/bin/env /Users/aalakkad/.asdf/shims/node
// <bitbar.title>Title goes here</bitbar.title>
// <bitbar.version>v1.0</bitbar.version>
// <bitbar.author>Your Name</bitbar.author>
// <bitbar.author.github>your-github-username</bitbar.author.github>
// <bitbar.desc>Short description of what your plugin does.</bitbar.desc>
// <bitbar.image>http://www.hosted-somewhere/pluginimage</bitbar.image>
// <bitbar.dependencies>python,ruby,node</bitbar.dependencies>
// <bitbar.abouturl>http://url-to-about.com/</bitbar.abouturl>

import bitbar, { darkMode, separator } from "bitbar";
import { DateTime, Duration } from "luxon";
import { Coordinates, CalculationMethod, PrayerTimes, Prayer } from "adhan";

const coordinates = new Coordinates(41.09798187627378, 28.7729281);
const params = CalculationMethod.Turkey();
const prayerTimes = new PrayerTimes(coordinates, new Date(), params);

const bitbarItems = [];

const times = {
	fajr: prayerTimes.fajr,
	sunrise: prayerTimes.sunrise,
	dhuhr: prayerTimes.dhuhr,
	asr: prayerTimes.asr,
	maghrib: prayerTimes.maghrib,
	isha: prayerTimes.isha,
};

let remaining = null;
let diffInSeconds = null;
Object.keys(times).forEach((key) => {
	const time = DateTime.fromJSDate(times[key]);
	times[key] = time;

	const diff = time.diff(DateTime.local(), "seconds");
	diffInSeconds = diff.values.seconds;
	bitbarItems.push(key.padEnd(30) + time.toFormat("HH:mm"));

	if (!remaining && diffInSeconds > 0) {
		remaining = diffInSeconds;
	}
});

const remainingString = Duration.fromMillis(remaining * 1000).toFormat("hh:mm");

const bitbarOutput = [
	{
		text: `🕌 ${remainingString}`,
		color: diffInSeconds < 1800 ? "red" : darkMode ? "#ffffff" : "#333333",
		dropdown: false,
	},
	separator,
	...bitbarItems,
];

bitbar(bitbarOutput, { font: "Monaco", size: "12" });
