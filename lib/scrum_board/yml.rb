module ScrumBoard

  require "yaml"
  require "active_support"
  
  class Yml
    def self.read(file)
      yaml_file = "#{file}.yml"
      YAML::load_file(yaml_file)
    end

    def self.read_from_config(file, env = ::Rails.env)
      yaml_file = File.join("config",file)
      configs = env ? read(yaml_file)[::Rails.env] : read(yaml_file)
      configs.is_a?(Hash) ? self.symbolize_keys(configs) : configs
    end
    
    def self.symbolize_keys(hash)
      hash.symbolize_keys!
      
      hash.each_value do |value|
        self.symbolize_keys value if value.is_a?(Hash)
      end
    end
    
  end

end