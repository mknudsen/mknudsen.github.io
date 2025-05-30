require 'rss'
require 'date'
require 'open-uri'

feed_urls = [
  'https://www.trueachievements.com/friendfeedrss.aspx?gamerid=1108778',
  'https://truesteamachievements.com/friendfeedrss.aspx?gamerid=109330',
  'https://www.truetrophies.com/friendfeedrss.aspx?gamerid=767394'
]

calendar_days_to_items = Hash.new { |hash, key| hash[key] = [] }

feed_urls.each do |url|
  begin
    URI.open(url, "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36") do |rss|
      content = rss.read
      feed = RSS::Parser.parse(content, false)

      if feed.nil? || feed.items.nil?
        puts "Failed to parse feed from #{url}: Response is not a valid RSS feed."
        next
      end

      feed.items.each do |item|
        day = item.pubDate.to_date
        calendar_days_to_items[day] << item
      end
    end
  rescue OpenURI::HTTPError => e
    puts "HTTP error fetching feed from #{url} : #{e.message}"
  rescue => e
    puts "Failed to fetch or parse feed from #{url} : #{e.message}"
  end
end

# item looks like
# <item>
#  <title>StudentLanguste won the Imperial Seal achievement in Dishonored 2</title>
#  <link>https://www.trueachievements.com/a225786/imperial-seal-achievement</link>
#  <description>StudentLanguste won the Imperial Seal achievement in Dishonored 2. The achievement is worth 10 points. 161460 tracked gamers now have this achievement. </description>
#  <pubDate>Tue, 14 Feb 2023 12:40:51 +0000</pubDate>
#  <guid isPermaLink="true">https://www.trueachievements.com/a225786/imperial-seal-achievement?gamerid=1108778</guid>
# </item>

# Initialize the output feed
output_feed = RSS::Maker.make('2.0') do |maker|

  maker.channel.author = 'Martin'
  maker.channel.title = 'Martins achievments'
  maker.channel.description = 'A combined feed of XBOX, Steam and PSN achievments'
  maker.channel.link = 'http://linkhal.de/achievements'
  maker.channel.language = 'en'
  maker.channel.updated = Time.now.to_s

  calendar_days_to_items.keys.each do |day|
    maker.items.new_item do |item|
      item.title = "achievements on #{day.strftime('%d.%m.%Y')}"
      item.content_encoded = "<ul>"
      calendar_days_to_items[day].each do |achievement|
        # see https://www.trueachievements.com/forum/viewthread.aspx?tid=1463482 if fixed
        fixed_title = achievement.title.sub('StudentLangustestarted', 'StudentLanguste started')
        item.content_encoded += "<li><a href='#{achievement.guid.content}'>#{fixed_title}</a></li>"
      end
      item.content_encoded += "</ul>"
      item.pubDate = day.to_s
    end
  end
end

output_file = 'achievements.xml'

File.open(output_file, 'w') do |file|
  file.write(output_feed.to_feed("2.0"))
end