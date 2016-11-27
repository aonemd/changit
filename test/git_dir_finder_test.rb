require 'test_helper'
require 'changit/git_dir_finder'

class GitDirFinderTest < Minitest::Test
  def test_find_all
    find_result = git_finder.find_all

    assert find_result.class == Array
    assert_equal find_result.map { |f| File.exist? f }, [true]
  end

  private

  def git_finder
    Changit::GitDirFinder.new
  end
end
