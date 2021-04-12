<div align="center">

# asdf-spin ![Build](https://github.com/pavloos/asdf-spin/workflows/Build/badge.svg) ![Lint](https://github.com/pavloos/asdf-spin/workflows/Lint/badge.svg)

[spin](https://spinnaker.io/guides/spin/) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add spin
# or
asdf plugin add spin https://github.com/pavloos/asdf-spin.git
```

spin:

```shell
# Show all installable versions
asdf list-all spin

# Install specific version
asdf install spin latest

# Set a version globally (on your ~/.tool-versions file)
asdf global spin latest

# Now spin commands are available
spin --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/pavloos/asdf-spin/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Pawel Fiuto](https://github.com/pavloos/)
