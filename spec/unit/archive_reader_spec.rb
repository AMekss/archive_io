module ArchiveIO
  RSpec.describe ArchiveReader do
    subject(:reader) { described_class.new }
    let(:results) { [] }
    before { reader.open("spec/fixtures/archive.zip") }

    describe "#each" do
      it "iterates through the archive multiple times" do
        reader.each { |file| results << file.pathname }
        reader.each { |file| results << file.pathname }

        expect(results).to eq [
          "archive/data_file.txt",
          "archive/xml/customers.xml",
          "archive/data_file.txt",
          "archive/xml/customers.xml",
        ]
      end
    end

    describe "#select" do
      it "selects files by pattern" do
        reader.select("*.xml") { |file| results << file.pathname }
        expect(results).to eq [ "archive/xml/customers.xml" ]
      end
    end

    describe "#close" do
      it "not possible to operate on closed archive" do
        reader.close
        expect { reader.each { |f| } }
          .to raise_error(LibArchive::NoArchiveError, "Archive is not open, call open with filename on archive before this operation")
      end
    end

    describe "yielded FileReader" do
      it "responds to #read" do
        reader.select("*.xml") do |file_reader|
          expect(file_reader.read(4)).to eq "<?xm"
          expect(file_reader.read(35)).to eq "l version=\"1.0\" encoding=\"UTF-8\"?>\n"
        end
      end

      it "return empty string when EOF reached" do
        reader.select("*.xml") do |file_reader|
          file_reader.read(1000)
          expect(file_reader.read(5)).to eq ""
        end
      end

      it "responds to #close" do
        reader.select("*.xml") do |file_reader|
          expect(file_reader).to respond_to(:close)
        end
      end
    end
  end
end
