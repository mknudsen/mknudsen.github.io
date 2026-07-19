# Ensure every page gets a unique, reasonably-sized meta description instead
# of always falling back to the generic site.description tagline.
module Jekyll
  class SeoTag
    class Drop < Jekyll::Drops::Drop
      MAX_DESCRIPTION_LENGTH = 155

      def description
        @description ||= begin
          desc = format_string(page["description"] || page["excerpt"]) ||
                 tag_page_description ||
                 site_description
          truncate_description(desc)
        end
      end

      private

      def tag_page_description
        return unless page["tag"]

        format_string(%(Posts tagged "#{page["tag"]}" on #{site_title}.))
      end

      def truncate_description(string)
        return string if string.nil? || string.length <= MAX_DESCRIPTION_LENGTH

        truncated = string[0...MAX_DESCRIPTION_LENGTH]
        last_space = truncated.rindex(" ")
        truncated = truncated[0...last_space] if last_space
        "#{truncated}…"
      end
    end
  end
end
