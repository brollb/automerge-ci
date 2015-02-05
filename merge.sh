#! /bin/bash
# Merge pushes to dev to master branch
export PAGER=cat
GIT_USER="$2"
GIT_PASS="$3"

CURRENT_BRANCH=$(git log -n 1 --pretty=%d HEAD | cut -d"," -f3 | cut -d" " -f2 | cut -d")" -f1)
FROM_BRANCH="dev"
TO_BRANCH="master"
echo "current branch is '$CURRENT_BRANCH'"

# Get the URL
URL=$(git remote -v | head -n1 | cut -f2 | cut -d" " -f1)
echo "Repo url is $URL"
PUSH_URL="https://$GIT_USER:$GIT_PASS@${URL:6}"

if [ "$CURRENT_BRANCH" = "$FROM_BRANCH" ] ; then
    git checkout $FROM_BRANCH && \

    echo "Checking out $TO_BRANCH..." && \
    git fetch origin $TO_BRANCH:$TO_BRANCH && \
    git checkout $TO_BRANCH && \
    #git checkout --track origin/$TO_BRANCH && \
    echo "Branches recognized " && \
    git branch -a && \
    git checkout $TO_BRANCH && \
    echo "Merging changes..." && \
    git merge $FROM_BRANCH && \
    echo "Pushing changes..." && \
    git push $PUSH_URL && \
    expect ":" && \
    send "$GIT_USER" && \
    expect ":" && \
    send "$GIT_PASS" && \
    echo "Merge complete!" || \
    echo "Error Occurred. Merge failed"
else
    echo "Not on $FROM_BRANCH. Skipping merge"
fi

