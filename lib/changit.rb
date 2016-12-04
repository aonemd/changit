require 'changit/version'
require 'changit/lexer/section_token'
require 'changit/lexer/key_value_token'
require 'changit/lexer'
require 'changit/git_dir_finder'
require 'changit/config_merger'
require 'changit/config_reader'
require 'changit/config_writer'
require 'changit/cli'

module Changit
  def self.run(src_file, target_files)
    # File to copy from
    config = ConfigReader.new(search_path: src_file).read

    # First, search directories inside the current pwd and make sure they contain a .git dir
    files_to_write_to = GitDirFinder.new(search_paths: target_files).find_all

    # Then, copy the gitconfig file content to each .git/config file in these directories
    ConfigWriter.new(config, files_to_write_to).write
  end
end
