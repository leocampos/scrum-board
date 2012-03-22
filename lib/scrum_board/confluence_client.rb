# encoding: utf-8

module ScrumBoard
  class ConfluenceClient
    def self.encode(text)
      text = text.gsub('[', '\[').gsub('{', '\{')
      num_spaces = text.match(/^ */)[0].size
      text.sub(/^ {#{num_spaces}}/, '&nbsp;' * num_spaces)
    end
    
    def page_source(title, space='plataforma')
      title = title.gsub(/\+/, ' ')
      
      page = call_confluence('getSource', :title => title)
      page.sub("Page source\n", '')
    end
    
    #extras: parent, labels, replace, content2, findReplace, noConvert, encoding
    def add_page(title, content, extras=nil)
      create_or_update('addPage', title, content, extras)
    end
    
    def store_page(title, content, extras=nil)
      create_or_update('storePage', title, content, extras)
    end
    
    private
    def call_confluence(action, extras=nil)
      user = confluence_configuration[:username]
      password = confluence_configuration[:password]

      vendor_confluence_path = "#{::Rails.root}/vendor/atlassian-cli-2.5.0"
      command = "#{vendor_confluence_path}/confluence.sh --server=https://confluence.abril.com.br --user=#{user} --password='#{password}' --space='plataforma' --action=#{action}"
      
      extras = default_extras(extras)
      extras[:encoding] = 'ISO-8859-1' if action == 'getSource'
      
      extras.each_pair do |key, value|
        command += " --#{key}='#{value}'"
      end

      debugger
      if action == 'getSource'
        path = temp_file_path
        
        `rm #{path};#{command} --file="#{path}"`
        
        File.open(path, "r:ISO-8859-1:UTF-8") { |f| f.read }
      else
        `#{command}`
      end
    end

    def confluence_configuration
      @confluence_configuration ||= ScrumBoard::Yml.read_from_config("confluence_account")
      @confluence_configuration
    end
    
    def temp_file_path
      path = nil
      Tempfile.open 'confluence-page', Rails.root.join('tmp'), 'wb:utf-8' do |file|
        path = file.path
      end
      path
    end
    
    def default_extras(given_extras={})
      extras = given_extras || {}
      
      extras[:encoding] = 'UTF-8' unless given_extras.has_key?(:encoding)
      extras
    end
    
    def create_or_update(action, title, content, extras)
      extras ||= {}
      extras[:title] = title

      begin
        file = Tempfile.new('confluence-page', Rails.root.join('tmp'))
        path = file.path
        extras[:file] = path
        
        File.open(path, 'w:UTF-8') {|f| f.write content }
        
        valor = call_confluence(action, extras)
      ensure
         file.close
         file.unlink
      end
      
      valor
    end
  end
end