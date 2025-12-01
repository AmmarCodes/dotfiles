######################
# GitLab-Specific    #
######################

# rails aliases
abbr --add railsc "bin/rails console"
abbr --add railsr "bin/rails routes | less"
abbr --add start-gdk "cd ~/projects/gitlab-development-kit/ && gdk start"
abbr --add stop-gdk "cd ~/projects/gitlab-development-kit/ && gdk stop"

# GitLab push with merge request options
abbr --add gpm "git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='frontend' -o merge_request.label='section::fulfillment' -o merge_request.label='group::utilization'"
abbr --add gpm! "git push -u origin -o merge_request.create -o merge_request.remove_source_branch -o merge_request.label='frontend' -o merge_request.label='section::fulfillment' -o merge_request.label='group::utilization' --no-verify"

function review -d "Review a GitLab merge request by passing the branch name"
    git fetch origin $argv
    git checkout origin/$argv
    gdk start db
    yarn install --check-files
    bundle install && bin/rails db:migrate && git checkout -- db
    # gdk restart
    noti -m 'MR is ready for review!'
end
