require 'test_helper'
require 'changit/config_loader'
require 'tempfile'

class ConfigLoaderTest < Minitest::Test
  def test_load
    file_contents = "[user]\n\tname = testname\n\temail = testmail@domain.com\n[core]\n\teditor = vim\n[color]\n\tui = true\n[rebase]\n\tautosquash = true\n".freeze

    Tempfile.open('.gitconfig') do |f|
      f.write file_contents
      f.close

      assert Changit::ConfigLoader.new(search_path: f).load == file_contents
    end
  end

  def test_load_file_not_found
    assert_raises(RuntimeError, "File #{config_loader.search_path} not found.") do
      config_loader.load
    end
  end

  private

  def config_loader
    Changit::ConfigLoader.new
  end
end
