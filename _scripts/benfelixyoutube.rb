#!/usr/bin/env ruby

require 'json'
require 'yaml'

CHANNEL_URL = "https://www.youtube.com/@BenFelixCSI/videos"
DATA_FILE = "_data/ben_felix_youtube.yml"

def fetch_youtube_videos(channel_url)
  command = "yt-dlp --flat-playlist -J #{channel_url}"
  output = `#{command}`
  json_data = JSON.parse(output)

  videos = json_data["entries"].map do |video|
    {
      "title" => video["title"],
      "link"   => "https://www.youtube.com/watch?v=#{video['id']}"
    }
  end.sort_by { |entry| entry["title"] }

  File.open(DATA_FILE, "w") { |file| file.write(videos.to_yaml) }
  puts "Saved #{videos.size} videos to #{DATA_FILE}"
end

fetch_youtube_videos(CHANNEL_URL)