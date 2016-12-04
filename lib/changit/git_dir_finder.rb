module Changit
  class GitDirFinder
    DEFAULT_SEARCH_PATH = Dir.pwd.freeze

    def initialize(search_paths: nil)
      search_paths ||= [DEFAULT_SEARCH_PATH]
      @search_paths = search_paths.collect! { |path| "#{path}/**/.git/config" }

      freeze
    end

    def find_all
      Dir.glob(@search_paths)
    end
  end
end
