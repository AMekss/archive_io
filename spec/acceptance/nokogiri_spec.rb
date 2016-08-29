require "nokogiri"

RSpec.describe ArchiveIO do
  context "with Nokogiri::XML::Reader" do
    it "feeds nokogiri straight from the archive" do
      results = []

      archive = ArchiveIO.open("spec/fixtures/archive.zip")
      archive.select("*.xml") do |cursor|
        Nokogiri::XML::Reader(cursor).each do |node|
          if node.name == "surename" && node.node_type == Nokogiri::XML::Reader::TYPE_ELEMENT
            results << node.inner_xml
          end
        end
      end
      archive.close

      expect(results).to eq %w{Dowe Simpson}
    end
  end
end
