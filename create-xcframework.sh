#!/bin/bash

set -euo pipefail
set -x

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 path/to/arm64 path/to/x86_64"
  exit 1
fi

if [[ "$1" == /* ]]; then
  binary1="$1"
else
  binary1="$PWD/$1"
fi

if [[ "$2" == /* ]]; then
  binary2="$2"
else
  binary2="$PWD/$2"
fi

workdir=$(mktemp -d)
pushd "$workdir"
mkdir -p libIndexStore.framework
lipo -create -output libIndexStore.framework/libIndexStore "$binary1" "$binary2"
xcodebuild -create-xcframework -framework libIndexStore.framework -output libIndexStore.xcframework
popd
mv "$workdir/libIndexStore.xcframework" .
