# ArchiveIO
[![Gem Version](https://badge.fury.io/rb/archive_io.svg)](https://badge.fury.io/rb/archive_io)
[![Build Status](https://travis-ci.org/AMekss/archive_io.svg?branch=master)](https://travis-ci.org/AMekss/archive_io)

Library which can traverse archived file (using [libarchive](http://www.libarchive.org/) under the hood) and yields IO like object on each file entry inside it for further streamline processing.

**Note:** [libarchive](http://www.libarchive.org/) have to be pre-installed and available on the host system

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'archive_io'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install archive_io

## Usage

Simple usage:

```ruby
archive = ArchiveIO.open("archive.7z")
archive.each do |cursor|
  puts cursor.pathname # prints out pathname inside archive
  puts cursor.read(10) # prints out beginning of each file
end
archive.close
```

This library can come in handy if you want to process huge xml files reading straight from the archive without uncompressing it and works nicely together with `Nokogiri::XML::Reader` and can be used as follows:

```ruby
archive = ArchiveIO.open("archive.7z")
archive.select("*.xml") do |cursor|
  Nokogiri::XML::Reader(cursor).each do |xml_node|
    # your custom xml processing logic goes here
  end
end
archive.close
```

## Development

After checking out the repo, run `bundle install` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/AMekss/archive_io.

