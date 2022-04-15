#!/bin/bash

set -euo pipefail

bundle install

# for some reason setting "source" => 'https://letterboxd.com/kndsn/rss/' fails at retrieving in
# github actions although it works locally so I download the feed manually
apk add curl
curl -o letterboxd.xml "https://letterboxd.com/kndsn/rss/"

ruby -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "letterboxd.xml",
      "tag" => "movies"
    })'
