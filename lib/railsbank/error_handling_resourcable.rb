# Error Handler
module ErrorHandlingResourcable
  def self.included(base)
    base.send(:resources) do
      default_handler do |response|
        next if (200...299).cover?(response.status)
        raise Railsbank::Error.new("#{response.error}: #{response.msg}")
      end
    end
  end
end
