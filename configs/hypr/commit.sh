#!/bin/bash

# Simple commit pin fetcher for Hyprland and Hyprscroller
GITHUB_API="https://api.github.com/repos"
CURRENT_DATE=$(date +"%Y-%m-%d")

# Function to get latest commit from a repo
get_latest_commit() {
    curl -s "$GITHUB_API/$1/commits?per_page=1" | jq -r '.[0].sha'
}

# Function to get latest release tag
get_latest_version() {
    curl -s "$GITHUB_API/$1/releases/latest" | jq -r '.tag_name'
}

# Fetch Hyprland data
HYPRLAND_REPO="hyprwm/Hyprland"
HYPRLAND_COMMIT=$(get_latest_commit "$HYPRLAND_REPO")
HYPRLAND_VERSION=$(get_latest_version "$HYPRLAND_REPO")

# Fetch Hyprscroller data
HYPRSCROLLER_REPO="maotseantonio/hyprscroller"
HYPRSCROLLER_COMMIT=$(get_latest_commit "$HYPRSCROLLER_REPO")
HYPRSCROLLER_VERSION=$(get_latest_version "$HYPRSCROLLER_REPO")

# Generate output
echo "Hyprland commit pin:"
echo "    ['$HYPRLAND_COMMIT'], # $HYPRLAND_VERSION ($CURRENT_DATE)"
echo
echo "Hyprscroller commit pin:"
echo "    ['$HYPRSCROLLER_COMMIT'], # $HYPRSCROLLER_VERSION ($CURRENT_DATE)"
