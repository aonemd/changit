require 'optparse'

module Changit
  class CLI
    attr_reader :options

    def initialize
      @options = {}
      @options[:target_paths] = []

      opt_parser = OptionParser.new do |opt|
        opt.banner = "Usage: changit [OPTIONS]"
        opt.separator  ""
        opt.separator  "Options"

        opt.on("-s", "--source SOURCE","Which gitconfig file to copy from") do |src_path|
          @options[:src_path] = src_path
        end

        opt.on("-t", "--target TARGET","Which directory to copy the config to."\
                                      " To copy to different directories, pass more than one -t argument each for one directory"
              ) do |target_path|
          @options[:target_paths] << target_path
        end

        opt.on("-v", "--version","Show version number") do
          puts Changit::VERSION
          exit
        end

        opt.on("-h", "--help","Show CLI options") do
          puts opt_parser
          exit
        end
      end

      opt_parser.parse!

      @options[:target_paths] = nil if @options[:target_paths].empty?
    end
  end
end
