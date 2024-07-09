#!/bin/bash
# This script is used to update the version information in a VERSION.json file with the latest release
# version of the s6-overlay project from GitHub. It fetches the latest tag name of the s6-overlay
# release and updates the version fields in the JSON file accordingly. This script is typically used
# in a CI/CD pipeline to ensure that the version information is always up-to-date with the latest
# release from the specified GitHub repository.

# Fetch the latest release version tag of the s6-overlay project from GitHub using the GitHub API.
# Authentication is done using the GITHUB_ACTOR and GITHUB_TOKEN environment variables.
version_s6=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/just-containers/s6-overlay/releases/latest" | jq -re .tag_name) || exit 1

# If the fetched version tag is empty, exit the script.
[[ -z ${version_s6} ]] && exit 0

# If the fetched version tag is null, exit the script.
[[ ${version_s6} == null ]] && exit 0

# Read the content of VERSION.json into a variable.
json=$(cat VERSION.json)

# Update the version fields in the JSON content:
# - .version is updated with the latest version tag, without the leading 'v'.
# - .version_s6 is updated with the latest version tag, without the leading 'v'.
# The updated JSON content is then written back to VERSION.json.
jq --sort-keys \
    --arg version "${version_s6//v/}" \
    --arg version_s6 "${version_s6//v/}" \
    '.version = $version | .version_s6 = $version_s6' <<< "${json}" | tee VERSION.json
