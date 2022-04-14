#!/bin/bash

set -euo pipefail

# bundle install

#sed 's#open(source)#URI.open(source)#' "$(bundle show jekyll-import)"/lib/jekyll-import/importers/rss.rb
#cat "$(bundle show jekyll-import)"/lib/jekyll-import/importers/rss.rb


apk add curl

curl -o my_file.xml "https://letterboxd.com/kndsn/rss/" 

ruby -w -r rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::RSS.run({
      "source" => "my_file.xml"
    })'
    
#ruby -w -r rubygems -e 'require "jekyll-import";
#    JekyllImport::Importers::RSS.run({
#      "source" => "https://letterboxd.com/kndsn/rss/"
#    })'
