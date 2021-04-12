# Contributing

Testing Locally:

```shell
asdf plugin test <plugin-name> <plugin-url> [--asdf-tool-version <version>] [--asdf-plugin-gitref <git-ref>] [test-command*]

#
asdf plugin test spin https://github.com/pavloos/asdf-spin.git "spin --version"
```

Tests are automatically run in GitHub Actions on push and PR.
