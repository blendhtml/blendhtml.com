#!/usr/bin/env bash

set -Eeuo pipefail

usage() {
cat <<EOF
Usage:
  $(basename "$0") <project> <username> [host] [transport]

Arguments:
  project     Project/repository name
  username    GitHub/GitLab username or organization
  host        Git host (default: https://github.com)
  transport   https (default) | ssh

Examples:
  # GitHub (HTTPS)
  $(basename "$0") my-app johndoe

  # GitHub (SSH)
  $(basename "$0") my-app johndoe https://github.com ssh

  # GitLab (HTTPS)
  $(basename "$0") my-app johndoe https://gitlab.com

  # GitLab (SSH)
  $(basename "$0") my-app johndoe https://gitlab.com ssh

  # Self-hosted Git
  $(basename "$0") my-app acme https://git.example.com

  # Self-hosted Git (SSH)
  $(basename "$0") my-app acme https://git.example.com ssh
EOF
exit 1
}

[[ $# -lt 2 || $# -gt 4 ]] && usage

PROJECT="$1"
OWNER="$2"
HOST="${3:-https://github.com}"
TRANSPORT="${4:-https}"

TEMPLATE="https://github.com/blendhtml/skeleton.git"

# Check requirements
for cmd in git composer; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: '$cmd' is not installed."
        exit 1
    fi
done

# Normalize host
HOST="${HOST%/}"

# Build remote URL
case "$TRANSPORT" in
    https)
        REMOTE="${HOST}/${OWNER}/${PROJECT}.git"
        ;;
    ssh)
        HOSTNAME="${HOST#https://}"
        HOSTNAME="${HOSTNAME#http://}"

        REMOTE="git@${HOSTNAME}:${OWNER}/${PROJECT}.git"
        ;;
    *)
        echo "Error: transport must be 'https' or 'ssh'."
        exit 1
        ;;
esac

echo "▶ Cloning skeleton..."
git clone "$TEMPLATE" "$PROJECT"

cd "$PROJECT"

echo "▶ Installing Composer dependencies..."
composer i

echo "▶ Removing template Git history..."
rm -rf .git

echo "▶ Initializing repository..."
git init

git add .
git commit -m "Initial commit"

echo "▶ Configuring remote..."
git remote add origin "$REMOTE"

cat <<EOF

✅ Project created successfully!

Project   : $PROJECT
Remote    : $REMOTE
Transport : $TRANSPORT

Next steps:

    cd $PROJECT
    git branch -M main
    git push -u origin main

EOF