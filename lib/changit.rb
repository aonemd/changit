require 'changit/version'
require 'changit/git_dir_finder'
require 'changit/config_reader'
require 'changit/lexer/section_token'
require 'changit/lexer/key_value_token'
require 'changit/lexer'
require 'changit/config_writer'

module Changit
  def self.run
    # File to copy from
    config = ConfigReader.new.read

    # First, search directories inside the current pwd and make sure they contain a .git dir
    files_to_write_to = GitDirFinder.new.find_all

    # Then, copy the gitconfig file content to each .git/config file in these directories
    ConfigWriter.new(config, files_to_write_to).write
  end
end
