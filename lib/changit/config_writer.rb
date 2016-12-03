module Changit
  class ConfigWriter
    attr_reader :config, :config_files

    def initialize(config, config_files)
      @config = config
      @config_files = config_files
    end

    def write
      @config_files.each do |path|
        merged_config = ConfigMerger.new(@config, File.read(path)).merge

        File.open(path, 'w') { |f| f.write(merged_config.to_s); f.close }
      end
    end
  end
end
