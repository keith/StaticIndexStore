#!/bin/bash

set -euo pipefail
set -x

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 path/to/universal/binary"
  exit 1
fi

if [[ "$1" == /* ]]; then
  binary="$1"
else
  binary="$PWD/$1"
fi

workdir=$(mktemp -d)
pushd "$workdir"
mkdir -p libIndexStore.framework
cp "$binary" libIndexStore.framework/libIndexStore
xcodebuild -create-xcframework -framework libIndexStore.framework -output libIndexStore.xcframework
popd
rm -rf ./libIndexStore.xcframework ./libIndexStore.xcqframework.zip
mv "$workdir/libIndexStore.xcframework" .
zip -r libIndexStore.xcframework.zip libIndexStore.xcframework
