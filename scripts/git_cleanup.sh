#!/bin/bash
# A simple script to clean up local git branches that have already been merged.

# Set the default branch name
DEFAULT_BRANCH="main"

echo "=================================================="
echo "          GIT LOCAL BRANCH CLEANUP UTILITY        "
echo "=================================================="

# Fetch the latest branches from remotes and prune deleted ones
echo "🔄 Fetching latest updates from remote..."
git fetch --all --prune

# Get current branch
CURRENT_BRANCH=$(git branch --show-current)

# If not on main, warn the user
if [ "$CURRENT_BRANCH" != "$DEFAULT_BRANCH" ]; then
    echo "⚠️  Warning: You are currently on branch '$CURRENT_BRANCH'."
    echo "It is highly recommended to run this script from '$DEFAULT_BRANCH'."
    read -p "Do you want to continue anyway? (y/n): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Exiting. No changes made."
        exit 0
    fi
fi

# List branches merged into default branch, excluding the default branch itself and current branch
MERGED_BRANCHES=$(git branch --merged "$DEFAULT_BRANCH" | grep -v "^\*" | grep -v "^[[:space:]]*$DEFAULT_BRANCH$")

if [ -z "$MERGED_BRANCHES" ]; then
    echo -e "\n🎉 Your local repository is already clean! No merged branches found."
    exit 0
fi

echo -e "\n🧹 The following local branches have been merged into '$DEFAULT_BRANCH' and can be safely deleted:"
echo "$MERGED_BRANCHES"
echo "--------------------------------------------------"

read -p "Do you want to delete these branches? (y/n): " delete_confirm
if [[ "$delete_confirm" =~ ^[Yy]$ ]]; then
    # Delete the merged branches safely
    echo "$MERGED_BRANCHES" | xargs -n 1 git branch -d
    echo -e "\n👍 Cleanup complete!"
else
    echo -e "\n❌ Cleanup cancelled. No branches were deleted."
fi

