#!/bin/bash

set -eu

VERSIONS=$(curl -s https://nodejs.org/dist/index.json | jq -r .[].version |
awk 'match($0, /v([0-9]+)/, x) {
  if (x[1] >= 12) {
    print $0
  }
}' | sort -V)

TAGS=$(git tag | sort -V)

PUBLISH_VERSIONS="$(IFS=\n; diff -u <(echo ${TAGS[*]}) <(echo ${VERSIONS[*]}) | sed -n '/^+[^+]/ s/^+v//p')"

echo ${PUBLISH_VERSIONS}

for v in $PUBLISH_VERSIONS
do
  # nothing Docker image...
  if [[ $v = "13.9.0" || $v = "13.10.0" ]]; then
    continue
  fi

  sed -i -e "s/^FROM node:.*/FROM node:${v}/" Dockerfile

  docker build -t catsoss/docker-node-headless-chrome-ja:${v} .
  docker push catsoss/docker-node-headless-chrome-ja:${v}

  git add Dockerfile
  git commit -m "feat: Bump node to ${v}"
  git tag -a v${v} -m v${v}
  git push origin main --tags
done
