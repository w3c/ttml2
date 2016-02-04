# How to build TTML2

To build TTML2 spec, you need to have Apache ant installed.

## Using github

1. Checkout an up to date branch.
2. Make sure that your config is set up to do rcs-keywords replacement (see below).
2. If you haven't already built the escaped entity includes do:
`ant build-escapes`
3. Edit `ttml.xml`
4. `ant sg`
5. If more edits, go to 3.
6. `ant rg` then commit using git, or `ant rgc`.
7. Create and submit your Pull Request.

To configure git to replace keywords like $Date$ add these lines to .git/config:

```
[filter "rcs-keywords"]
	clean  = .gitfilters/rcs-keywords.clean
	smudge = .gitfilters/rcs-keywords.smudge %f
```

Commit messages should have at least a first line be preceded by `[ttml]` with a summary of the changes. Subsequent lines can be used for further detail.

