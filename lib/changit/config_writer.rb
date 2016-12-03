module Changit
  class ConfigWriter
    attr_reader :config, :config_files

    def initialize(config, config_files)
      @config = config
      @config_files = config_files
    end
    
    def write
      config_lexer = Lexer.new(@config)
      config_token_hash = config_lexer.token_hash

      @config_files.each do |path|
        file_lexer = Lexer.new(File.read(path))
        file_token_hash = file_lexer.token_hash

        unless file_token_hash.empty?
          file_token_hash.each do |k, v|
            if config_token_hash[k]
              # calling `sort!` changes the order of the key_value pairs
              config_token_hash[k].sort!
              file_token_hash[k].sort!

              config_token_hash[k].each_with_index do |e, i|
                if v.include?(e)
                  # update it
                  file_token_hash[k][i].rhs = e.rhs
                else
                  # push it
                  file_token_hash[k].push(e)
                end
              end
            end
          end
        end

        File.open(path, 'w') { |f| f.write(config_lexer.to_s); f.close }
      end
    end
  end
end
