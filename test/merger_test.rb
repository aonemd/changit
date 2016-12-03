require 'test_helper'
require 'changit/lexer'
require 'changit/lexer/section_token'

class ConfigMergerTest < Minitest::Test
  def test_merge
    merger = config_merger
    merged_config = merger.merge

    assert_kind_of Changit::Lexer, merged_config
  end

  def test_hash_difference
    difference_hash = config_merger.hash_difference({ "key1" => 1, "key2" => 2 }, { "key1" => 7 })
    assert_equal difference_hash, { "key2" => 2 }
  end

  private

  def config_merger
    src_config = "[user]\n\tname = anothername\n".freeze
    target_config = "[user]\n\tname = testname\n\temail = testmail@domain.com\n[core]\n\teditor = vim\n[color]\n\tui = true\n[rebase]\n\tautosquash = true\n".freeze
    Changit::ConfigMerger.new(src_config, target_config)
  end
end
