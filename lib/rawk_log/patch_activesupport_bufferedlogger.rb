
if defined?(ActiveSupport::BufferedLogger)

  module ActiveSupport

    # Format the buffered logger with timestamp/severity info.
    class BufferedLogger
      def add(severity, message = nil, progname = nil, &block)
        return if @level > severity
        message = (message || (block && block.call) || progname).to_s
        # If a newline is necessary then create a new message ending with a newline.
        # Ensures that the original message is not mutated.
        message = "#{message}\n" unless message[-1] == ?\n
        message = message.gsub(/\n/," (pid:#{$$})\n")
        buffer << message
        auto_flush
        message
      end
    end
  end

end
