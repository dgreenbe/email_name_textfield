# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'email_name_textfield/version'

Gem::Specification.new do |spec|
  spec.name          = "email_name_textfield"
  spec.version       = EmailNameTextfield::Rails::VERSION
  spec.authors       = ["Dana Greenberg"]
  spec.email         = ["dgreenbe@constantcontact.com"]
  spec.description   = "Text area for pasting in multiple emails and validating by name and e-mail address"
  spec.summary       = "Text area entry tool that allows you to paste e-mail names and addresses from common mail clients such as Gmail, Yahoo! and Outlook. This tool will recognize the pasted input and parse out the first and last name as well as validating the e-mail address."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency "coffee-rails", "> 2.1.0"
end
