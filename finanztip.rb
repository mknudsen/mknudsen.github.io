#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'yaml'
require 'uri'

url = "https://www.finanztip.de/sitemaps/"
doc = Nokogiri::HTML(URI.open(url))

base_url = "https://www.finanztip.de" # The base TLD for relative links

sitemap_links = doc.css(".ftdefaultcontentelement .container ul li a").map do |link|
  href = link['href']
  next unless href # Skip if href is nil

  # Add TLD to relative URLs
  full_url = URI.join(base_url, href).to_s

  {
    "title" => link.text.strip,
    "link"   => full_url
  }
end.compact.sort_by { |entry| entry["title"] }

File.open("_data/finanztip.yml", "w") do |file|
  file.write(sitemap_links.to_yaml)
end