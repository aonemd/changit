require 'test_helper'
require 'changit/config_writer'
require 'tempfile'

class ConfigWriterTest < Minitest::Test
  def test_write
    writer = config_writer
    writer.write

    assert writer.config == File.read(writer.config_files.first)
  end

  private

  def config_writer
    config = "[user]\n\tname = testname\n\temail = testmail@domain.com\n[core]\n\teditor = vim\n[color]\n\tui = true\n[rebase]\n\tautosquash = true\n".freeze
    config_files = [Tempfile.new('config')]

    Changit::ConfigWriter.new(config, config_files)
  end
end
