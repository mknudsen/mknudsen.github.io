#!/usr/bin/env ruby

require 'jekyll-import'
require_relative '../_plugins/mastodon_importer'

# Configuration
SOURCE_URL = 'https://nrw.social/@brainwashed/with_replies.rss'
TAG = 'nrw.social'
TITLE_WORDS = 5

#TODO parameterize via link

# Run the importer
JekyllImport::Importers::MastodonRSS.run({
  'source' => SOURCE_URL,
  'tag' => TAG,
  'canonical_link' => true,
  'title_words' => TITLE_WORDS
})
