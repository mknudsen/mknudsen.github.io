#!/bin/sh

pwd
ls

gem install jekyll-import
gem install safe_yaml
ruby -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "https://letterboxd.com/kndsn/rss/",
      "tag" => "movies"
    })'
