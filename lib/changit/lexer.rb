module Changit
  class Lexer
    RULES = [
      [/\[(.*?)\]/, SectionToken].freeze,
      [/^[^(=|\[|\s)]*\s*\=\s*[^(=|\[|\])]*/, KeyValueToken].freeze
    ].freeze

    attr_reader :tokens, :token_hash

    def initialize(expression)
      @original_expression = expression
      @tokens = tokenize
      @token_hash = to_hash
    end

    def to_s
      @tokens.map(&:to_s).join
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
          token_hash[token] = []
        else
          token_hash[token_hash.to_a.last[0]].push(token)
        end
      end

      token_hash
    end
  end
end
