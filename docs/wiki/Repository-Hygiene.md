# Repository Hygiene

Keep the template lightweight by versioning only source code, configuration, and small vendored dependencies.

## Do Commit
- `main.cpp`, `src/`
- `shaders/`
- `CMakeLists.txt`, toolchain files (`cmake/toolchains/linux-*.cmake`, `cmake/toolchains/windows-*.cmake`)
- `external/` (GLAD source)
- Scripts (`build-multi.sh`, platform helpers)
- Documentation (`README.md`, `docs/wiki/`)
- Icon assets (`icon/`, `icon.iconset/`)

## Do Not Commit
- Generated build directories (`build*/`, `mac-*/`, `win-*/`)
- Produced binaries (`OGLQuickstart*`)
- Large toolchains (`llvm-mingw/`), SDK caches (`WinOpenGLFiles/`, `gitDownloadPackages/`)
- Temporary files (`temp/`, `.DS_Store`, compiler intermediates)

## Workflow Tips
1. Run `git status` before committing to ensure only allowed files are staged.
2. If you need local SDKs, keep them outside the repository root or add them to `.gitignore`.
3. Use release artifacts (GitHub Releases, zip files) to share compiled binaries instead of tracking them in source control.
4. For team projects, document any additional dependencies in the wiki so others can reproduce your environment.
