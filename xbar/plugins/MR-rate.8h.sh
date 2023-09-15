#!/usr/bin/env zsh

# Metadata:
# <xbar.title>MR Rate</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Ammar Alakkad</xbar.author>
# <xbar.author.github>AmmarCodes</xbar.author.github>
# <xbar.desc>Show MR rate for the past month</xbar.desc>
# <xbar.dependencies>glab, jq</xbar.dependencies>

export PATH='/opt/homebrew/bin:/opt/homebrew/opt/coreutils/libexec/gnubin/:$PATH'

count=$(glab api "merge_requests?author_username=aalakkad&created_after=$(date -d "-1 month" +%Y-%m-%d)T00:00:00Z" | jq length)

echo "MRs: $count"
