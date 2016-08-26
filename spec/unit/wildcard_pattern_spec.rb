module ArchiveIO
  RSpec.describe WildcardPattern do
    TEST_EXPRESSIONS = {
      "*hn" => { "john" => true, "johnny" => false, "hanna" => false },
      "*hn*" => { "john" => true, "johnny" => true, "hanna" => false },
      "hn" => { "john" => false, "johnny" => false, "hanna" => false },
      "*h*n*" => { "john" => true, "johnny" => true, "hanna" => true },
    }

    TEST_EXPRESSIONS.each do |expression, expected_results|
      expected_results.each do |test_string, expected_result|
        it "#{expression} returns #{expected_result} for #{test_string}" do
          wildcard = described_class.new(expression)
          expect(wildcard.match?(test_string)).to eq expected_result
        end
      end
    end
  end
end
