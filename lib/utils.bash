#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="spin"
TOOL_TEST="spin --version"
PLATFORM=$(uname | tr '[:upper:]' '[:lower:]')
TAC_COMMAND=$([ "$PLATFORM" == 'linux' ] && echo 'tac' || echo 'tail -r')

gh_curl_opts=(-fsSL)

if [ -n "${GH_API_TOKEN:-}" ]; then
  gh_curl_opts=("${gh_curl_opts[@]}" -H "Authorization: token $GH_API_TOKEN")
fi

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions ()
{
    latest_published=$(curl -s https://storage.googleapis.com/spinnaker-artifacts/spin/latest);
    releases=$(
    curl "${gh_curl_opts[@]}" https://api.github.com/repos/spinnaker/spin/tags |
      grep -E '"name": "(version-|v)[0-9.]+"' |
      grep -o '[0-9]*\.[0-9]*\.[0-9]*' | sort_versions | uniq
  );
    # print all version up to $latest_published inclusive
    echo "$releases" | awk "NR==1,/$latest_published/"
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"
  url=https://storage.googleapis.com/spinnaker-artifacts/spin/${version}/${PLATFORM}/amd64/spin

  echo "* Downloading $TOOL_NAME release $version..."
  curl -fsSL -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"
  local -r install_path_bin="${install_path}/bin"
  local -r tool_path="${install_path_bin}/${TOOL_NAME}"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "${install_path_bin}"
    download_release "$version" "${tool_path}"
    chmod +x "${tool_path}"

    test -x "${tool_path}" || fail "Expected ${tool_path} to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )

}
