#!/usr/bin/env ruby

# Metadata allows your plugin to show up in the app, and website.
#
#  <xbar.title>Milestone days left</xbar.title>
#  <xbar.version>v1.0</xbar.version>
#  <xbar.author>Ammar Alakkad</xbar.author>
#  <xbar.author.github>AmmarCodes</xbar.author.github>
#  <xbar.desc>Displays how many days left for the current GitLab milestone</xbar.desc>
#  <xbar.image></xbar.image>
#  <xbar.dependencies>ruby</xbar.dependencies>
#  <xbar.abouturl>https://ammar.codes</xbar.abouturl>

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
  output = "📆 #{work_days_left} days"
  output << " | color=red" if work_days_left < 7
  output << "\n---\n"
  output << "#{current_release['version']} last day: #{release_date}"
  puts output
end
