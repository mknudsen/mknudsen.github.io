# Optimize markdownify to skip processing plain strings
module Jekyll
  class SeoTag
    class Filters
      alias_method :original_markdownify, :markdownify
      
      # Skip markdownify if string doesn't contain markdown syntax
      def markdownify(string)
        return string unless string.is_a?(String)
        
        # Only run markdownify if string contains potential markdown
        if string.match?(/[*_`\[\]#>]/)
          original_markdownify(string)
        else
          string
        end
      end
    end
  end
end
