#!/usr/bin/env node

import { DateTime, Duration } from "luxon";
import { Coordinates, CalculationMethod, PrayerTimes } from "adhan";

const coordinates = new Coordinates(41.09798187627378, 28.7729281);
const params = CalculationMethod.Turkey();
const prayerTimes = new PrayerTimes(coordinates, new Date(), params);

const items = [];

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
  // items.push(key + " - " + time.toFormat("HH:mm"));
  items.push(time.toFormat("HH:mm"));

  if (!remaining && diffInSeconds > 0) {
    remaining = diffInSeconds;
  }
});

const remainingString = Duration.fromMillis(remaining * 1000).toFormat("hh:mm");

console.log(remainingString);
console.log(items.join("\n"));
