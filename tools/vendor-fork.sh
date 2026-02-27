#!/usr/bin/env sh

set -eu

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
  echo "Usage: sh ./tools/vendor-fork.sh <repo-url-or-path> <vendor/prefix> [ref]" >&2
  exit 1
fi

repo="$1"
prefix="$2"
ref="${3:-main}"

case "$prefix" in
  vendor/*) ;;
  *)
    echo "Error: prefix must start with vendor/ (got: $prefix)" >&2
    exit 1
    ;;
esac

if [ -d "$prefix" ]; then
  git subtree pull --prefix="$prefix" "$repo" "$ref" --squash
else
  git subtree add --prefix="$prefix" "$repo" "$ref" --squash
fi
