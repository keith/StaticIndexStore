# StaticIndexStore

This is a script for building `libIndexStore.dylib` from
[`apple/llvm-project`](https://github.com/apple/llvm-project) as a
static archive. This way you do not have to add a non-portable rpath in
your binaries to Xcode internals or distribute the library alongside
your tool.
