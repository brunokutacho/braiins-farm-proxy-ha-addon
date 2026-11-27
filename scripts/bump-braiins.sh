#!/usr/bin/env bash
# Usage: scripts/bump-braiins.sh <braiins-proxy-version>
# Reads SHA256SUMS of that release and rewrites the three ARG lines of the Dockerfile.
set -euo pipefail
VERSION="${1:?usage: $0 <version>}"
BASE="${BRAIINS_BASE_URL:-https://downloads.braiins.com/braiins-proxy}"
DOCKERFILE="$(dirname "$0")/../braiins_sv2_proxy/Dockerfile"

SUMS="$(curl -fsSL "${BASE}/assets/${VERSION}/SHA256SUMS")"
get() { echo "$SUMS" | grep "  braiins-proxy-linux-$1.tar.gz\$" | awk '{print $1}'; }
A="$(get aarch64)"; X="$(get x86_64)"
[ -n "$A" ] && [ -n "$X" ] || { echo "checksums not found for ${VERSION}" >&2; exit 1; }

sed -i \
  -e "s/^ARG BRAIINS_VERSION=.*/ARG BRAIINS_VERSION=${VERSION}/" \
  -e "s/^ARG SHA256_AARCH64=.*/ARG SHA256_AARCH64=${A}/" \
  -e "s/^ARG SHA256_X86_64=.*/ARG SHA256_X86_64=${X}/" \
  "$DOCKERFILE"
echo "Dockerfile updated to ${VERSION}."
echo "Compare the checksums with https://downloads.braiins.com/braiins-proxy/ before publishing."
