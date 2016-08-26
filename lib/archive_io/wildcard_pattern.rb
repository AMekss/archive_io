module ArchiveIO
  class WildcardPattern
    def initialize(expression)
      escaped = Regexp.escape(expression).gsub('\*','.*?')
      @regex = Regexp.new "^#{escaped}$", Regexp::IGNORECASE
    end

    def match?(str)
      !!(str =~ @regex)
    end
  end
end
