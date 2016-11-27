require 'test_helper'
require 'changit/config_reader'
require 'tempfile'

class ConfigReaderTest < Minitest::Test
  def test_read
    file_contents = "[user]\n\tname = testname\n\temail = testmail@domain.com\n[core]\n\teditor = vim\n[color]\n\tui = true\n[rebase]\n\tautosquash = true\n".freeze

    Tempfile.open('.gitconfig') do |f|
      f.write file_contents
      f.close

      assert Changit::ConfigReader.new(search_path: f).read == file_contents
    end
  end

  def test_read_file_not_found
    assert_raises(RuntimeError, "File #{config_reader.search_path} not found.") do
      config_reader.read
    end
  end

  private

  def config_reader
    Changit::ConfigReader.new
  end
end
