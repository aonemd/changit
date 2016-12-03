module Changit
  class ConfigMerger
    def initialize(src_config, target_config)
      @src = src_config
      @target = target_config
    end

    # comapre and merge src_config into target_config into a lexer
    def merge
      src_lexer = Lexer.new(@src)
      src_token_hash = src_lexer.token_hash

      target_lexer = Lexer.new(@target)
      target_token_hash = target_lexer.token_hash

      if target_token_hash.empty?
        target_lexer = src_lexer
      else
        target_token_hash.each do |k, v|
          if src_token_hash[k]
            target_token_hash[k].merge!(src_token_hash[k])
          end
        end

        config_difference = hash_difference(src_token_hash, target_token_hash)
        target_token_hash.merge!(config_difference)
        target_lexer.reconstruct_tokens_from_hash!
      end

      target_lexer
    end

    # return the difference between two hashes
    def hash_difference(src_token_hash, target_token_hash)
      src_token_hash.dup.delete_if { |k, _| target_token_hash.key?(k) }
    end
  end
end
