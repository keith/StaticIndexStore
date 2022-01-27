# StaticIndexStore

This is a script for building `libIndexStore.dylib` from
[`apple/llvm-project`](https://github.com/apple/llvm-project) as a
static archive. This way you do not have to add a non-portable rpath in
your binaries to Xcode internals or distribute the library alongside
your tool.

# Usage

See [the releases
page](https://github.com/keith/StaticIndexStore/releases) to get the
right version based on your version of Xcode / Swift.

With Swift Package Manager you can use the `.binaryTarget` type with
this:

```swift
targets: [
    // Some targets
    .binaryTarget(
        name: "libIndexStore",
        url: "See releases page",
        checksum: "See releases page"
    ),
],
```

Then add `libIndexStore` to the `dependencies` of another target.

If you want to use this without Swift Package Manager you can download
the xcframework and use the internal `libIndexStore.framework` however
you'd normally include dependencies.

## Notes

- Depending on how you're building your tools, you might be better off
  using cmake and depending on this target manually in your build. See
  [index-import](https://github.com/MobileNativeFoundation/index-import)
  for an example
