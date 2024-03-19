#!/usr/bin/env ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title milestone
# @raycast.mode inline
# @raycast.refreshTime 12h

# Optional parameters:
# @raycast.icon 📆

# Documentation:
# @raycast.description How many days left in the current milestone
# @raycast.author AmmarCodes
# @raycast.authorURL https://raycast.com/AmmarCodes

require 'open-uri'
require 'yaml'
require 'date'

# Fetch YAML file from URL
url = 'https://gitlab.com/gitlab-com/www-gitlab-com/-/raw/master/data/releases.yml'
file_contents = URI.open(url).read

# Parse YAML
data = YAML.safe_load(file_contents)

# Sort releases by date
sorted_releases = data.sort_by { |release| Date.parse(release['date']) }

# Find the current release
current_date = Date.today
current_release = sorted_releases.find { |release| Date.parse(release['date']) - 6 > current_date }

# Calculate work days until release (assuming release is 6 days earlier)
if current_release
  release_date = Date.parse(current_release['date']) - 6
  work_days_left = (release_date - Date.today).to_i
  puts "#{current_release['version']}: (#{work_days_left} days left)"
  puts "---"
  puts "Last day: #{release_date}"
else
  puts "No future releases found."
end
