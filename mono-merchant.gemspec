# frozen_string_literal: true

# to load all /lib files
$LOAD_PATH.push File.expand_path("lib", __dir__)

require_relative "lib/mono-merchant/version"

Gem::Specification.new do |spec|
  spec.name = "mono-merchant"
  spec.version = MonoMerchant::VERSION
  spec.authors = ["okliv"]
  spec.email = [""]

  spec.summary = "The \"mono-merchant\" gem is a powerful Ruby library designed for seamless integration with Monobank's acquiring system. It provides a convenient way to handle Monobank payments."
  spec.description = "The \"mono-merchant\" gem simplifies Monobank payment integration in Ruby applications. It provides an simplified interface and essential functionalities for generating invoice requests, verifying transactions, handling webhooks, and ensuring data integrity. With this gem, you can quickly and securely implement Monobank payments."
  spec.homepage = "https://github.com/okliv/mono-merchant"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/okliv/mono-merchant"
  spec.metadata["changelog_uri"] = "https://github.com/okliv/mono-merchant/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rest-client", "~> 2.1"
  spec.add_dependency "base64", "~> 0.2"
  spec.add_dependency "json", "~> 2.5"
  spec.add_dependency "money", "~> 6.16"
  spec.add_dependency "activesupport", "~> 7"

  # spec.add_development_dependency "rspec"
  # spec.add_development_dependency "pry"
  # spec.add_development_dependency "simplecov"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
