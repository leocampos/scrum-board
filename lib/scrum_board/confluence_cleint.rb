module ScrumBoard
  class ConfluenceClient
    def page_source(title, space='plataforma')
      title = title.gsub(/\+/, ' ')
      user = 'plataforma_alexandria'
      password = 'eu tambem nao sei'

      vendor_confluence_path = "#{::Rails.root}/vendor/atlassian-cli-2.5.0"
      command = "#{vendor_confluence_path}/confluence.sh --server=https://confluence.abril.com.br --user=#{user} --password='#{password}' --action=getSource --title='#{title}' --space='#{space}'"

      `#{command}`
    end
  end
end