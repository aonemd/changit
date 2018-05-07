module Changit
  class Lexer
    class KeyValueToken
      attr_reader :lhs    # left-hand side
      attr_accessor :rhs  # right-hand side

      def initialize(key_value)
        @lhs, @rhs = key_value.split('=', 2).map(&:strip)
      end

      def to_s
        "\t#{@lhs} = #{@rhs}\n"
      end
    end
  end
end
