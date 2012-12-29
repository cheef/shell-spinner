require "shell-spinner/version"

module ShellSpinner

  class Runner
    def initialize
      require 'stringio'
      @buffer, @original_output = StringIO.new, $stdout
    end

    def wrap_block text = nil, &block
      with_message text do
        with_spinner &block
      end
    end

    private

      def catch_user_output
        $stdout = @buffer
        yield
      ensure
        $stdout = @original_output
      end

      def with_message text = nil
        require 'colorize'

        begin
          print "#{text}... " unless text.nil?
          catch_user_output { yield }
          print "done\n".colorize(:green) unless text.nil?
          print user_output.colorize(:blue)
        rescue Exception => e
          print "fail\n".colorize(:red) unless text.nil?
          print user_output.colorize(:blue)
          re_raise_exception e
        end
      end

      def user_output
        @buffer.rewind
        @buffer.read
      end

      def with_spinner
        chars  = %w{ | / - \\ }
        thread = Thread.new { yield }

        while thread.alive?
          @original_output.print chars[0]
          sleep 0.1
          @original_output.print "\b"

          chars.push chars.shift
        end

        thread.join
      end

      def re_raise_exception e
        raise begin
          new_exception = build_new_exception(e)
          new_exception.set_backtrace e.backtrace
          new_exception
        end
      end

      # Needs for cases when custom exceptions needs a several required arguments
      def build_new_exception e
        e.class.new(e.message)
      rescue
        Exception.new e.message
      end
    end
end

def ShellSpinner text = nil, &block
  runner = ShellSpinner::Runner.new
  runner.wrap_block text, &block
end
