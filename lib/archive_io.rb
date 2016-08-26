require "archive_io/version"
require "archive_io/archive_reader"

module ArchiveIO
  def self.open(filename)
    reader = ArchiveIO::ArchiveReader.new
    reader.open(filename)
    reader
  end
end
