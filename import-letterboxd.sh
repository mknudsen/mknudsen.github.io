#!/bin/sh

gem install jekyll-import
ruby -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "https://letterboxd.com/kndsn/rss/",
      "tag" => "movies"
    })'