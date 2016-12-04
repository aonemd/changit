module Changit
  class ConfigReader
    DEFAULT_SEARCH_PATH = "#{Dir.pwd}/.gitconfig".freeze

    attr_reader :search_path

    def initialize(search_path: nil)
      search_path ||= DEFAULT_SEARCH_PATH
      @search_path = search_path

      freeze
    end

    def read
      search_result = Dir.glob(@search_path)

      if search_result.empty?
        fail "File #{@search_path} not found."
      else
        File.read(search_result.first)
      end
    end
  end
end
