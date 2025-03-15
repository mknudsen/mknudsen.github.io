require 'net/http'
require 'uri'

def resolve_shortlink(url)
  @cache ||= {}
  return @cache[url] if @cache.key?(url)

  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri)
  while response.is_a?(Net::HTTPRedirection)
    uri = URI.parse(response['location'])
    response = Net::HTTP.get_response(uri)
  end
  resolved_url = uri.to_s
  @cache[url] = resolved_url
  resolved_url
rescue Exception => e
  puts "Error resolving #{url}: #{e.message}"
  url
end

Dir.glob('_posts/*.html') do |filename|
  content = File.read(filename)
  updated_content = content.gsub(/http:\/\/ift\.tt\/\w+/) do |shortlink|
    resolved_link = resolve_shortlink(shortlink)
    puts "Resolved #{shortlink} to #{resolved_link}"
    resolved_link
  end
  File.write(filename, updated_content) if content != updated_content
end

puts "All shortlinks resolved and updated."