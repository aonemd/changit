require 'test_helper'
require 'changit/lexer'
require 'changit/lexer/section_token'

class LexerTest < Minitest::Test
  def test_tokenize
    tokens = lexer.tokens

    assert_kind_of Array, tokens
    refute_empty tokens
    assert_equal tokens.size, lexer.original_expression.each_line.count
  end

  def test_to_hash
    token_hash = lexer.token_hash

    assert_kind_of Hash, token_hash
    refute_empty token_hash
    assert_kind_of_array Changit::Lexer::SectionToken, token_hash.keys
  end

  private

  def lexer
    config = "[user]\n\tname = testname\n\temail = testmail@domain.com\n[core]\n\teditor = vim\n[color]\n\tui = true\n[rebase]\n\tautosquash = true\n".freeze
    Changit::Lexer.new(config)
  end
end
