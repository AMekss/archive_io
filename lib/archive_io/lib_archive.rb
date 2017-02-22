require "ffi"

module ArchiveIO
  module LibArchive
    extend FFI::Library

    OK = 0
    EOF = 1

    ffi_lib ["archive", "libarchive.so.2", "libarchive.so.13"]

    attach_function :archive_version_string, [], :string
    attach_function :archive_read_open_filename, [:pointer, :string, :size_t], :int
    attach_function :archive_read_support_compression_all, [:pointer], :int
    attach_function :archive_read_support_format_all, [:pointer], :int
    attach_function :archive_error_string, [:pointer], :string
    attach_function :archive_read_new, [], :pointer
    attach_function :archive_read_finish, [:pointer], :int
    attach_function :archive_read_header_position, [:pointer], :int
    attach_function :archive_read_next_header, [:pointer, :pointer], :int
    attach_function :archive_read_data, [:pointer, :pointer, :size_t], :size_t

    # entry
    attach_function :archive_entry_new, [], :pointer
    attach_function :archive_entry_filetype, [:pointer], :mode_t
    attach_function :archive_entry_pathname, [:pointer], :string

    class NoArchiveError < StandardError; end
    class Error < StandardError
      def initialize(archive)
        super "#{LibArchive::archive_error_string(archive)}"
      end
    end
  end
end
