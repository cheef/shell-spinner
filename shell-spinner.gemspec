# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "shell-spinner/version"

Gem::Specification.new do |s|
  s.name        = "shell-spinner"
  s.version     = ShellSpinner::VERSION
  s.authors     = ["Ivan Garmatenko"]
  s.email       = %w(cheef.che@gmail.ru)
  s.homepage    = "https://github.com/cheef/shell-spinner"
  s.summary     = %q{Animated spinner for shell}
  s.description = %q{Gem provides animated spinner for UNIX shell and could be used with rake tasks and any console scripts}

  s.files         = `git ls-files`.split("\n")
  s.require_paths = %w(lib)

  s.add_runtime_dependency "colorize"
end
