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
        raise e
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
end

def ShellSpinner text = nil, &block
  ShellSpinner.wrap text, &block
end
