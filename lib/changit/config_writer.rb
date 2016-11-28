module Changit
  class ConfigWriter
    attr_reader :config, :config_files

    def initialize(config, config_files)
      @config = config
      @config_files = config_files
    end
    
    def write
      hsrc = parse(@config)

      @config_files.each do |path|
        hdst = parse(File.read(path))
        hmerged = comp_and_merge(hsrc, hdst)

        out = ""
        hmerged.each do |k, v|
          out += "#{k}\n"
          v.each do |v_k, v_v|
            out += "\t#{v_k} = #{v_v}\n"
          end
        end

        File.open(path, 'w') { |f| f.write(out); f.close }
      end
    end

    def parse(config)
      h = Hash.new

      config.each_line do |line|
        line.strip!
        line.gsub!(/\s+/, '')

        if line =~ /^\[\w+\]$/
          h[line] = {}
        else
          key, value = line.split('=') 
          h[h.to_a.last[0]][key] = value
        end
      end

      h
    end

    def comp_and_merge(hsrc, hdst)
      hdifference = hsrc.dup.delete_if { |k, _| hdst.key?(k) }

      hdst.each do |k, v|
        if hsrc[k]
          hdst[k] = hdst[k].merge(hsrc[k])
        end
      end

      unless hdifference.empty?
        hdst.merge!(hdifference)
      end

      hdst
    end
  end
end
