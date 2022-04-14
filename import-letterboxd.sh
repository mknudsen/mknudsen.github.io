#!/bin/bash

set -euo pipefail

bundle install

sed 's#open(source)#URI.open(source)#' "$(bundle show jekyll-import)"/lib/jekyll-import/importers/rss.rb
cat "$(bundle show jekyll-import)"/lib/jekyll-import/importers/rss.rb

ruby -w -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "https://letterboxd.com/kndsn/rss/",
      "tag" => "movies"
    })'
