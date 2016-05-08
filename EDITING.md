# TTML2 PROCESS GUIDELINES

The following guidelines apply to the various processes used in the development and maintenance of the TTML2 specification.

## Pull Requests

A pull request (PR) should be created for every non-trivial change to the specification; furthermore, each pull request should be associated with an issue.

When creating a remote branch that is intended to lead to a PR, that branch should be named ``issue-0000(-token)+`` where the issue number is zero filled into ``0000``. For example:

<pre>
issue-0158-use-of-60-seconds-in-clock-expression
issue-0156-create-customizations-section
</pre>

## Pull Request Merging

The editor may merge a PR, with or without changes, at any time, and with or without notice. The editor may delegate the merging of a PR to the creator of the PR or to another party. If merging a PR has been delegated, then the editor and delgatee should coordinate mergers to avoid unintended conflicts.

PR merges occur only from a PR branch to the gh-pages (default) branch.

## Non-Pull-Request Commits

Only the editor or a delegatee may perform a non-PR based commit. These should generally be limited to trivial changes or changes that do not affect specificiation content.
