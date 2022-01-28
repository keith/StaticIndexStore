# StaticIndexStore

This is distribution of `libIndexStore.dylib` from
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

## Building

To create a new release for this project follow these steps:

- Clone [`apple/llvm-project`](https://github.com/apple/llvm-project)
  and checkout the branch you want to build from
- Cherry pick the most recent commit from the releases page, or use the
  `example.patch` checked into this repo as a starting point
- Create a `build` directory in the root of the repo
- Run cmake with something like `cmake ../llvm -G Ninja
  -DLLVM_ENABLE_PROJECTS='clang;clang-tools-extra'
  -DCMAKE_BUILD_TYPE=Release -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0`
- Run `ninja libIndexStore.dylib`
- If you'd like a fat binary for supporting arm64 and x86_64 macs,
  repeat the steps above while also adding
  `-DCMAKE_OSX_ARCHITECTURES=x86_64` (or `arm64`, the opposite of your
  host machine) to your cmake invocation
- Run `create-xcframework.sh binary1 binary2` to create the combined
  framework

## Notes

- This method doesn't actually produce a static binary, but it produces
  a relocatable object file which is similar enough for this use case.
  This is because cmake cannot create distributable static library
  targets that include all of their nested dependencies
- Be sure to pass `-dead_strip` to your linker when linking this library
  with a binary to save on binary size (you likely already are)
- Depending on how you're building your tools, you might be better off
  using cmake and depending on this target manually in your build. See
  [index-import](https://github.com/MobileNativeFoundation/index-import)
  for an example
