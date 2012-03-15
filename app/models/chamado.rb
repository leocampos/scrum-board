class Chamado
  def update_deploy_list
    confluence_client.store_page('titulo', 'content')
  end
  
  def create_page
    confluence_client.add_page('titulo', 'content')
  end
  
  private
  def confluence_client
    @client ||= ScrumBoard::ConfluenceClient.new
  end
end