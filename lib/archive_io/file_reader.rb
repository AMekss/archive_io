require "archive_io/lib_archive"

module ArchiveIO
  class FileReader
    attr_reader :pathname

    def initialize(pathname, archive)
      @pathname = pathname
      @archive = archive
    end

    def read(size)
      buffer = FFI::MemoryPointer.new(:char, size)
      return nil if LibArchive::archive_read_data(@archive, buffer, size) < 0
      buffer.get_string(0)
    end

    def close
      # does nothing, purpose of having it is to support IO like interface
    end
  end
  private_constant :FileReader
end
