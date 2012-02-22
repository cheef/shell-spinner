# Shell Spinner

Gem provides animated spinner for UNIX shell and could be used with rake tasks and any console scripts.
It basically wraps any code and show spinner until code isn't completed.

## Installation

    gem install shell-spinner
    
In **Rails 3**, add this to your Gemfile and run the ```bundle``` command.
    
    gem "shell-spinner"

## Usage

The main gem function ```ShellSpinner``` accepts text string as first argument,
which is not required, but it's better to have it for pretty output.
And it accepts block of code. So spinner will be presented while block is running.

    require 'shell-spinner'

    # With message
    ShellSpinner "Positive result" do
      Rake::Task["foo:bar"].invoke
    end

    # Spinner without message
    ShellSpinner do
      sleep 1
    end

    # With exception
    ShellSpinner "Code with exception" do
      sleep 2
      raise "Some exception"
    end

This code produces output similar to:

    > Positive result... done
    > Code with exception... fail
    > <exception message and backtrace>
    
I can't show you a spinner there, but promise - it appears :)