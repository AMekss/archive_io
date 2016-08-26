require "archive_io/lib_archive"
require "archive_io/header"
require "archive_io/file_reader"
require "archive_io/wildcard_pattern"

module ArchiveIO
  class ArchiveReader
    HEADER_HANDLING_STRATEGIES = {
      LibArchive::OK => -> (pointer) { Header.new(pointer) },
      LibArchive::EOF => -> (_) { nil },
    }.freeze

    def initialize
      ObjectSpace.define_finalizer(self, &method(:close))
    end

    def open(filename)
      close

      @archive = LibArchive::archive_read_new
      @filename = filename

      assert_operation_valid(LibArchive::archive_read_support_compression_all(archive))
      assert_operation_valid(LibArchive::archive_read_support_format_all(archive))
      assert_operation_valid(LibArchive::archive_read_open_filename(archive, filename, 10240))
    end

    def each
      raise LibArchive::NoArchiveError, "Archive is not open, call open with filename on archive before this operation" unless archive

      while header = next_header
        yield FileReader.new(header.pathname, archive) if header.file?
      end

      open(@filename) #reopen file for the next call
    end

    def select(pattern)
      wildcard = WildcardPattern.new(pattern)

      each do |file|
        yield file if wildcard.match?(file.pathname)
      end
    end

    def close
      LibArchive::archive_read_finish(archive) if archive
    ensure
      @archive = nil
      @filename = nil
    end

    private

    attr_reader :archive

    def header_handler(code)
      HEADER_HANDLING_STRATEGIES.fetch(code) { raise LibArchive::Error, archive }
    end

    def next_header
      header = LibArchive::archive_entry_new
      header_handler(LibArchive::archive_read_next_header(archive, header)).call(header.read_pointer)
    end

    def assert_operation_valid(operation_result_code)
      raise LibArchive::Error, archive if operation_result_code != LibArchive::OK
    end
  end
end
