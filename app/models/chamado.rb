# encoding: utf-8

class Chamado
  def initialize(data={})
    @project = data[:project]
    @content = data[:content]
  end
  
  def generate(version, content=@content)
    update_deploy_list version
    create_page version, content
  end
  
  def update_deploy_list(version)
    page = confluence_client.page_source('Chamados+de+deploy')
    
    page = add_line_to_page(page, version)
    
    confluence_client.store_page('Chamados de deploy', page)
  end
  
  def create_page(version, content=@content)
    extras = {:parent => @project.confluence_parent_page}
    
    confluence_client.add_page(page_name(version), content, extras)
  end
  
  def page_name(version)
    "#{@project.name.downcase} - #{version}"
  end
  
  def today
    Time.now.strftime("%d/%m/%Y")
  end
  
  private
  def confluence_client
    @client ||= ScrumBoard::ConfluenceClient.new
  end
  
  def add_line_to_page(page, version)
    linha = "| #{@project.name} | #{version} | [IM-000000|plataforma:#{page_name(version)}] | #{today} | | Aberto | Piloto | | |"
    
    remaining_page = page.match(/\|\| Sistema [^\n]*$/).post_match
    topo = %q{h1. Deploys dos sistemas Alexandria:


|| Sistema || Versão || Chamado || Dt. Abertura || Dt. Execução || Status || Tipo || Motivo deploy emergencial || Problemas do deploy/Validação ||
}
    
    "#{topo}#{linha}#{remaining_page}"
  end
end