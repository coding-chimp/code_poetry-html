# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require 'code_poetry-html/version'

Gem::Specification.new do |spec|
  spec.name          = "code_poetry-html"
  spec.version       = CodePoetry::Formatter::HTMLFormatter::VERSION
  spec.authors       = ["Bastian Bartmann"]
  spec.email         = ["babartmann@gmail.com"]
  spec.description   = %q{Default HTML formatter for CodePoetry}
  spec.summary       = %q{Default HTML formatter for CodePoetry}
  spec.homepage      = "https://github.com/coding-chimp/code_poetry-html"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'sprockets'
  spec.add_development_dependency 'sass'
end
