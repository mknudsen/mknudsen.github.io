#!/bin/bash

set -euo pipefail

gem install jekyll-import
gem install safe_yaml
ruby -w -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "https://letterboxd.com/kndsn/rss/",
      "tag" => "movies"
    })'
