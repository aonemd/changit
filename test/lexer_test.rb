require 'test_helper'
require 'changit/lexer'
require 'changit/lexer/section_token'

class LexerTest < Minitest::Test
  def test_tokenize
    l = lexer
    tokens = l.tokens

    assert_kind_of Array, tokens
    refute_empty tokens
    assert_equal tokens.size, l.original_expression.each_line.count
  end

  def test_to_hash
    l = lexer
    token_hash = l.token_hash

    assert_kind_of Hash, token_hash
    refute_empty token_hash
  end

  def test_reconstruct_tokens_from_hash
    l = lexer
    old_tokens = l.tokens
    l.token_hash["[user]"].merge!({ 'name' => 'newname' })
    l.reconstruct_tokens_from_hash!

    refute_equal lexer.tokens, old_tokens
  end

  private

  def lexer
    config = "[user]\n\tname = testname\n\temail = testmail@domain.com\n[core]\n\teditor = vim\n[color]\n\tui = true\n[rebase]\n\tautosquash = true\n".freeze
    Changit::Lexer.new(config)
  end
end
