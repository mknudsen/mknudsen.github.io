#!/usr/bin/env ruby

require 'yaml'
require 'pathname'

# Find all markdown files in _posts directory
posts_dir = Pathname.new('_posts')

# Process each post file
Dir.glob(File.join(posts_dir, '*')).each do |file_path|
  next if File.directory?(file_path)
  
  # Read file content
  content = File.read(file_path)
  
  # Extract YAML front-matter (between --- separators)
  if content.match(/^(---\s*\n)(.*?)(\n---\s*\n)/m)
    front_matter = $2
    
    # Parse YAML front-matter
    begin
      yaml_data = YAML.unsafe_load(front_matter)
      
      # Check if tags or tag field exists and is empty
      has_tags = false
      
      # Handle both 'tags' and 'tag' fields
      if yaml_data
        # Check for 'tags' field (array or string)
        if yaml_data['tags']
          tags_value = yaml_data['tags']
          # Empty array or empty string means no tags
          if tags_value == [] || tags_value == ""
            has_tags = false
          else
            # Non-empty array or string means tags exist
            has_tags = true
          end
        # Check for 'tag' field (single tag)
        elsif yaml_data['tag']
          tag_value = yaml_data['tag']
          # Empty string or nil means no tags
          if tag_value == "" || tag_value.nil?
            has_tags = false
          else
            # Non-empty string means tags exist
            has_tags = true
          end
        end
      end
      
      # If no tags found, output relative path
      if !has_tags && yaml_data
        relative_path = Pathname.new(file_path).relative_path_from(Pathname.new('.')).to_s
        puts relative_path
      elsif !yaml_data || !yaml_data.key?('tags') && !yaml_data.key?('tag')
        # If neither tags nor tag field exists at all, consider it "no tags"
        relative_path = Pathname.new(file_path).relative_path_from(Pathname.new('.')).to_s
        puts relative_path
      end
    rescue => e
      # In case of YAML parsing error, skip this file
      puts "Error parsing YAML in #{file_path}: #{e.message}"
    end
  end
end
