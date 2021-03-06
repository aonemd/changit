module Changit
  class Lexer
    class SectionToken
      attr_accessor :section

      def initialize(section)
        @section = section
      end

      def to_s
        "#{@section}\n"
      end
    end
  end
end
