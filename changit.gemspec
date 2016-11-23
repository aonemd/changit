# coding: utf-8
require File.expand_path('../lib/changit/version', __FILE__)

Gem::Specification.new do |gem|  
  gem.authors       = ["aaooki"]
  gem.email         = ["aaooki7@gmail.com"]
  gem.description   = %q{Change git config for multiple projects at once.}
  gem.summary       = %q{Change git config for multiple projects at once.}
  gem.homepage      = "http://aaooki.github.io"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = ["changit"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "changit"
  gem.require_paths = ["lib"]
  gem.version       = Changit::VERSION
end 
