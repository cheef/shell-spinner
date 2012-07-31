require "shell-spinner/version"

module ShellSpinner

  def self.wrap text = nil, &block
    with_message text do
      join_spinner_thread(block)
    end
  end

  private

    def self.with_message text = nil
      require 'colorize'

      begin
        print "#{text}... " unless text.nil?
        yield
        print "done\n".colorize(:green) unless text.nil?
      rescue Exception => e
        print "fail\n".colorize(:red) unless text.nil?
        re_raise_exception e
      end
    end

    def self.join_spinner_thread proc
      chars  = %w{ | / - \\ }
      thread = Thread.new { proc.call }

      while thread.alive?
        print chars[0]
        sleep 0.1
        print "\b"

        chars.push chars.shift
      end

      thread.join
    end

    def self.re_raise_exception e
      raise begin
        new_exception = build_new_exception(e)
        new_exception.set_backtrace e.backtrace
        new_exception
      end
    end

    # Needs for cases when custom exceptions needs a several required arguments
    def self.build_new_exception e
      e.class.new(e.message)
    rescue
      Exception.new e.message
    end
end

def ShellSpinner text = nil, &block
  ShellSpinner.wrap text, &block
end
