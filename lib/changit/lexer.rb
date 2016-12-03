module Changit
  class Lexer
    RULES = [
      [/\[(.*?)\]/, SectionToken].freeze,
      [/^[^(=|\[|\s)]*\s*\=\s*[^(=|\[|\])]*/, KeyValueToken].freeze
    ].freeze

    attr_reader :original_expression, :tokens, :token_hash

    def initialize(expression)
      @original_expression = expression
      @tokens = tokenize
      @token_hash = to_hash
    end

    def to_s
      @tokens.map(&:to_s).join
    end

    def reconstruct_tokens_from_hash!
      tokens = []
      @token_hash.each do |section, key_value|
        tokens << SectionToken.new(section)  
        key_value.each { |lhs, rhs| tokens << KeyValueToken.new("#{lhs} = #{rhs}") }
      end

      @tokens = tokens
    end

    private

    def tokenize
      expression = @original_expression.gsub(/\t/, '')

      tokens = []
      expression.each_line do |line|
        RULES.each do |rule, token_type|
          lexmeme = line.slice(rule)

          if (lexmeme)
            tokens << token_type.new(lexmeme)
            break
          end
        end
      end

      tokens
    end

    def to_hash
      token_hash = {}

      @tokens.map do |token|
        if token.class == SectionToken
          token_hash[token.section] = {}
        else
          token_hash[token_hash.to_a.last[0]][token.lhs] = token.rhs
        end
      end

      token_hash
    end
  end
end
