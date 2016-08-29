# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'archive_io/version'

Gem::Specification.new do |spec|
  spec.name          = "archive_io"
  spec.version       = ArchiveIO::VERSION
  spec.authors       = ["Artūrs Mekšs"]
  spec.email         = ["arturs.mekss@gmail.com"]

  spec.summary       = %q{Library which can traverse archived file and yields io like object on each file in it.}
  spec.description   = %q{Library which can traverse archived file (using `libarchive` under the hood) and yield io like object on each file entry inside it for further processing.}
  spec.homepage      = "https://github.com/AMekss/archive_io"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ffi", "~> 1.9"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "nokogiri"
end
