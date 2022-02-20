#!/bin/sh

gem install jekyll-import
ruby -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "'${GOODREADS_FEED}'",
      "tag" => "books"
    })'