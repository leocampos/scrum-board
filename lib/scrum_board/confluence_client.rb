module ScrumBoard
  class ConfluenceClient
    def page_source(title, space='plataforma')
      title = title.gsub(/\+/, ' ')
      
      call_confluence('getSource', :title => title)
    end
    
    #extras: parent, labels, replace, content2, findReplace, noConvert, encoding
    def add_page(title, content, extras)
      create_or_update('add_page', title, extras)
    end
    
    def store_page(title, content, extras)
      create_or_update('store_page', title, extras)
    end
    
    private
    def call_confluence(action, extras)
      user = confluence_configuration[:username]
      password = confluence_configuration[:password]

      vendor_confluence_path = "#{::Rails.root}/vendor/atlassian-cli-2.5.0"
      command = "#{vendor_confluence_path}/confluence.sh --server=https://confluence.abril.com.br --user=#{user} --password='#{password}' --space='plataforma' --action=#{action}"
      
      extras ||= {}
      extras.each_pair do |key, value|
        command += " --#{key}='#{value}'"
      end
      
      `#{command}`
    end
    
    def write_tmp_file(content)
      debugger
      temp_file = Tempfile.new 'confluence-page', Rails.root.join('tmp')
      temp_file.write(content)
      temp_file
    end

    def confluence_configuration
      @confluence_configuration ||= ScrumBoard::Yml.read_from_config("confluence_account")
      @confluence_configuration
    end
    
    def create_or_update(action, title, extras)
      extras ||= {}
      extras[:title] = title
      
      valor = nil
      
      begin
        file = write_tmp_file(content)
        extras[:file] = file.path
        
        valor = call_confluence(action, extras)
      ensure
         file.close
         file.unlink   # deletes the temp file
      end
      
      valor
    end
  end
end