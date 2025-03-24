#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'yaml'

url = "https://gerd-kommer.de/blog/archiv/"
doc = Nokogiri::HTML(URI.open(url))

blog_articles = doc.css(".gdlr-core-blog-grid-content-wrap h3")

articles = blog_articles.map do |article|
  {
    "title" => article.text.strip,
    "link"  => article.at_css('a')['href']
  }
end.sort_by { |article| article["title"] }

File.open("_data/kommer_articles.yml", "w") do |file|
  file.write(articles.to_yaml)
end
