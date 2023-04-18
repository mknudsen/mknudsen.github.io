#!/bin/bash

set -euo pipefail

bundle install

ruby -r rubygems ./aggregate_achievements_feeds.rb

ruby -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "achievements.xml",
      "tag" => "achievements"
    })'
