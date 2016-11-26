module Changit
  class GitDirFinder
    DEFAULT_SEARCH_PATH = Dir.pwd.freeze

    def initialize(search_path: DEFAULT_SEARCH_PATH)
      @search_path = "#{search_path}/**/.git/config"
    end

    def find_all
      Dir.glob(@search_path)
    end
  end
end
