# coding: utf-8
require File.expand_path('../lib/changit/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ahmad Saleh"]
  gem.email         = ["aonemdsalej@gmail.com"]
  gem.description   = %q{An over-engineered tool to change git config for multiple projects at once.}
  gem.summary       = %q{An over-engineered tool to change git config for multiple projects at once.}
  gem.homepage      = "https://github.com/aonemdsaleh/changit"

  gem.files         = `git ls-files`.split($\).reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  gem.executables   = ["changit"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "changit"
  gem.require_paths = ["lib"]
  gem.version       = Changit::VERSION
end
