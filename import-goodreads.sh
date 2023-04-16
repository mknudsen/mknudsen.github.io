#!/bin/bash

#!/bin/bash

set -euo pipefail

bundle install

# for some reason setting "source" => '$GOODREADS_FEED' fails at retrieving in
# github actions although it works locally so I download the feed manually
apk update
apk upgrade
apk add curl
GOODREADS_FEED=$1
curl -o goodreads.xml "$GOODREADS_FEED"

ruby -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "goodreads.xml",
      "tag" => "books"
    })'

