require "archive_io/lib_archive"

module ArchiveIO
  class Header
    S_IFMT   = 0170000
    S_IFREG  = 0100000 #  regular file

    def initialize(pointer)
      @pointer = pointer
    end

    def file?
      LibArchive::archive_entry_filetype(@pointer) & S_IFMT == S_IFREG
    end

    def pathname
      LibArchive::archive_entry_pathname(@pointer)
    end
  end
  private_constant :Header
end
