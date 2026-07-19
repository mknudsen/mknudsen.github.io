# Profile SEO tag performance in detail
module Jekyll
  class SeoTag
    class Drop < Jekyll::Drops::Drop
      TIMINGS = Hash.new { |h, k| h[k] = { count: 0, time: 0.0 } }
      
      class << self
        def report_timings
          puts "\n=== SEO Tag Method Timings ==="
          total = TIMINGS.values.sum { |v| v[:time] }
          TIMINGS.sort_by { |k, v| -v[:time] }.each do |method, stats|
            avg = stats[:time] / stats[:count]
            pct = (stats[:time] / total * 100)
            puts format("%-30s %6d calls  %8.3fs (%5.1f%%)  %8.6fs avg", 
                       method, stats[:count], stats[:time], pct, avg)
          end
          puts format("\n%-30s            %8.3fs (100.0%%)", "TOTAL", total)
        end
      end
      
      def self.time_method(method_name)
        original_method = instance_method(method_name)
        define_method(method_name) do |*args, &block|
          start = Time.now
          result = original_method.bind(self).call(*args, &block)
          TIMINGS[method_name][:time] += Time.now - start
          TIMINGS[method_name][:count] += 1
          result
        end
      end
      
      # Wrap all significant methods
      time_method :title
      time_method :description
      time_method :author
      time_method :json_ld
      time_method :image
      time_method :canonical_url
      time_method :format_string
      time_method :page_title
      time_method :site_title
      time_method :page_locale
      time_method :date_modified
      time_method :date_published
    end
  end
end

# Also profile the Filters class
module Jekyll
  class SeoTag
    class Filters
      FILTER_TIMINGS = Hash.new { |h, k| h[k] = { count: 0, time: 0.0 } }
      
      class << self
        def report_timings
          puts "\n=== SEO Tag Filter Timings ==="
          total = FILTER_TIMINGS.values.sum { |v| v[:time] }
          FILTER_TIMINGS.sort_by { |k, v| -v[:time] }.each do |method, stats|
            avg = stats[:time] / stats[:count]
            pct = (stats[:time] / total * 100) if total > 0
            puts format("%-30s %6d calls  %8.3fs (%5.1f%%)  %8.6fs avg", 
                       method, stats[:count], stats[:time], pct || 0, avg)
          end
          puts format("\n%-30s            %8.3fs (100.0%%)", "FILTER TOTAL", total) if total > 0
        end
        
        def time_filter(method_name)
          original_method = instance_method(method_name)
          define_method(method_name) do |*args, &block|
            start = Time.now
            result = original_method.bind(self).call(*args, &block)
            FILTER_TIMINGS[method_name][:time] += Time.now - start
            FILTER_TIMINGS[method_name][:count] += 1
            result
          end
        end
      end
      
      time_filter :markdownify
      time_filter :strip_html
      time_filter :normalize_whitespace
      time_filter :escape_once
      time_filter :absolute_url
      time_filter :uri_escape
    end
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  Jekyll::SeoTag::Drop.report_timings
  Jekyll::SeoTag::Filters.report_timings
end
