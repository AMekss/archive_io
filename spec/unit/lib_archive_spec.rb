module ArchiveIO
  RSpec.describe LibArchive do
    describe ".archive_version_string" do
      it "returns non-empty string thus bindings are correct" do
        expect(LibArchive.archive_version_string).to be_a String
        expect(LibArchive.archive_version_string).not_to be_empty
      end
    end
  end
end
