# How to build TTML2

To build TTML2 spec, you need to have Apache ant installed.

## Using github

1. Checkout an up to date branch (e.g. `main`).
3. Edit `ttml.xml`
4. `ant build` - the build artefacts are stored in the `/spec/build` directory, e.g. `index.html` is the TTML2 HTML specification.
5. If more edits, go to 3.
6. Create and submit your Pull Request. Note that build artefacts are git ignored.
7. Travis CI will create the build artefacts and push them to a branch with the same name, with `-build` appended.

Commit messages should have at least a first line be preceded by `[ttml]` with a summary of the changes. Subsequent lines can be used for further detail.
