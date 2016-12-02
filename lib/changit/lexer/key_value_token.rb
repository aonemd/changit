module Changit
  class Lexer
    class KeyValueToken
      include Comparable

      attr_reader :lhs    # left-hand side
      attr_accessor :rhs  # right-hand side

      def initialize(key_value)
        @lhs, @rhs = key_value.split('=').map(&:strip)
      end

      def to_s
        "\t#{@lhs} = #{@rhs}\n"
      end

      def <=>(another)
        self.lhs <=> another.lhs
      end
    end
  end
end
