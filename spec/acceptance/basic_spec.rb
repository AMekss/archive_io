RSpec.describe ArchiveIO do
  context "with archived file" do
    it "reads archived content" do
      results = []

      archive = ArchiveIO.open("spec/fixtures/archive.zip")
      archive.each do |file|
        results << file.pathname
        results << file.read(10)
      end
      archive.close

      expect(results).to eq([
        "archive/data_file.txt",
        "Archived t",
        "archive/xml/customers.xml",
        "<?xml vers",
      ])
    end
  end

  context "with unarchived file" do
    it "raises error" do
      expect {
        archive = ArchiveIO.open("spec/fixtures/unarchived_file.txt")
        archive.each { |file| file.pathname }
      }.to raise_error(ArchiveIO::LibArchive::Error, "Unrecognized archive format")
    end
  end
end
