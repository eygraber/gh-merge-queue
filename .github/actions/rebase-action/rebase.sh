#!/bin/bash

set -e

if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is not set."
  exit 1
fi

if [ -z "$GITHUB_REPOSITORY" ]; then
    echo "Error: GITHUB_REPOSITORY is not set."
    exit 1
fi

if [ -z "$GITHUB_EVENT_PATH" ]; then
    echo "Error: GITHUB_EVENT_PATH is not set."
    exit 1
fi

PR_NUMBER=$(jq -r ".pull_request.number" "$GITHUB_EVENT_PATH")
if [ -z "$PR_NUMBER" ]; then
    echo "Error: Could not get PR number."
    exit 1
fi

PR_DATA=$(gh pr view "$PR_NUMBER" --json state,reviewDecision,statusCheckRollup,headRefName,baseRefName,mergeable)

PR_STATE=$(echo "$PR_DATA" | jq -r ".state")
if [ "$PR_STATE" != "OPEN" ]; then
    echo "PR is not open. Skipping."
    exit 0
fi

PR_REVIEW_DECISION=$(echo "$PR_DATA" | jq -r ".reviewDecision")
if [ "$PR_REVIEW_DECISION" != "APPROVED" ]; then
    echo "PR is not approved. Skipping."
    exit 0
fi

PR_CHECKS_STATUS=$(echo "$PR_DATA" | jq -r '.statusCheckRollup | map(select(.status == "COMPLETED" and .conclusion != "SUCCESS" and .conclusion != "SKIPPED" and .conclusion != null)) | length')
if [ "$PR_CHECKS_STATUS" -gt 0 ]; then
    echo "Some checks have failed. Skipping."
    exit 0
fi

PR_MERGEABLE=$(echo "$PR_DATA" | jq -r ".mergeable")
if [ "$PR_MERGEABLE" != "MERGEABLE" ]; then
    BASE_REF_NAME=$(echo "$PR_DATA" | jq -r ".baseRefName")
    HEAD_REF_NAME=$(echo "$PR_DATA" | jq -r ".headRefName")

    if [ "$INPUT_FAIL_ON_OUT_OF_DATE" = "true" ]; then
        echo "PR is not mergeable. Failing."
        exit 1
    else
        echo "PR is not mergeable. Rebasing."
        git config --global user.name "github-actions[bot]"
        git config --global user.email "41898282+github-actions[bot]@users.noreply.github.com"
        git fetch origin "$BASE_REF_NAME"
        git fetch origin "$HEAD_REF_NAME"
        git checkout "$HEAD_REF_NAME"
        git rebase "origin/$BASE_REF_NAME"
        git push --force-with-lease
    fi
fi

echo "PR is up to date."
exit 0
