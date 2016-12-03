require 'test_helper'
require 'changit/config_writer'
require 'tempfile'

class ConfigWriterTest < Minitest::Test
  def test_write_to_existing_file
    writer = config_writer
    writer.write

    assert writer.config == File.read(writer.config_files.first)
  end

  def test_write_to_empty_file
    writer = empty_config_writer
    writer.write

    assert writer.config == File.read(writer.config_files.first)
  end

  private

  def config_writer
    config = "[user]\n\tname = testname\n\temail = testmail@domain.com\n[core]\n\teditor = vim\n[color]\n\tui = true\n[rebase]\n\tautosquash = true\n".freeze
    # this creates an actual file in /tmp you should remove it if you want to
    config_files = [File.new("/tmp/config1237879867", 'w')]

    Changit::ConfigWriter.new(config, config_files)
  end

  def empty_config_writer
    config = "[user]\n\tname = testname\n\temail = testmail@domain.com\n[core]\n\teditor = vim\n[color]\n\tui = true\n[rebase]\n\tautosquash = true\n".freeze
    config_files = [Tempfile.new('config')]

    Changit::ConfigWriter.new(config, config_files)
  end
end
